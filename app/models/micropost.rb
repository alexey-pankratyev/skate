# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  to_id      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Micropost < ActiveRecord::Base
  
  @@reply_to_regexp = /\A@([^\s]*)/

  attr_accessible :content, :to

  attr_accessor   :recipient
  

  NICKNAME_REGEX = /@\w+/i
  DIRECT_MESSAGE_REGEX = /^d\s[a-z](\w*[a-z0-9])*\s/i

  belongs_to :user
  belongs_to :to, class_name: "User" 
  # has_many :recipients, :dependent => :destroy
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true 
  
  default_scope order: 'microposts.created_at DESC'
  
  before_save :extract_in_reply_to

  # Return microposts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  # same, including replies.
  scope :from_users_followed_by_including_replies, lambda { |user| followed_by_including_replies(user)}
  
  def direct_message_format?
    self.content.clone.match(DIRECT_MESSAGE_REGEX) && message_recipient
  end

  def to_direct_message_hash
    body = self.content.clone
    body.slice!(DIRECT_MESSAGE_REGEX) # remove 'd username '
    
    { :content => body, :sender_id => self.user_id,
      :recipient_id => message_recipient.id }
  end

 private

  # Return an SQL condition for users followed by the given user.
  # We include the user's own id as well.
  def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
       where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            { :user_id => user })
  end
  
  def self.followed_by_including_replies(user)
    followed_ids = %(SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id)
    where("user_id IN (#{followed_ids}) OR user_id = :user_id OR to_id = :user_id",
          { :user_id => user })
  end

  def extract_in_reply_to
    if match = @@reply_to_regexp.match(content)
      user = User.find_by_nickname(match[1].downcase)
      self.to=user if user
    end
  end

 def extract_username_from_direct_message
      username = self.content.clone.match( DIRECT_MESSAGE_REGEX )[0].strip
      username.slice!('d ')
      username
 end

 def message_recipient
      @recipient ||= User.find_by_name(extract_username_from_direct_message)
 end
 
end
