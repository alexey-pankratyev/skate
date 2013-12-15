class Micropost < ActiveRecord::Base

  attr_accessible :content

  NICKNAME_REGEX = /@\w+/i

  belongs_to :user

  has_many :replies, foreign_key: "to_id", class_name: "Micropost"
  belongs_to :to, class_name: "User" 
 
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true 
  
  default_scope order: 'microposts.created_at DESC'
  before_save :extract_in_reply_to

  # same, including replies.
  scope :from_users_followed_by_including_replies, lambda { |user| followed_by_including_replies(user)}
  @@reply_to_regexp = /\A@([^\s]*)/

  # def self.from_users_followed_by(user)
  #   followed_user_ids = "SELECT followed_id FROM relationships
  #                        WHERE follower_id = :user_id"
  #   micropost_ids = "SELECT micropost_id FROM recipients WHERE user_id = :user_id"
  #   where("id IN (#{micropost_ids}) OR user_id IN (#{followed_user_ids}) OR user_id = :user_id",
  #         user_id: user.id)
  # end
  
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

end
