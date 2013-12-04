class Micropost < ActiveRecord::Base

  attr_accessible :content, :recipients

  NICKNAME_REGEX = /@\w+/i

  belongs_to :user

  has_many :recipients, :dependent => :destroy
  has_many :replied_users, :through => :recipients, :source => "user" 
 
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true 
  
  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    micropost_ids = "SELECT micropost_id FROM recipients WHERE user_id = :user_id"
    where("id IN (#{micropost_ids}) OR user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

 after_save :save_recipients

  private

   def save_recipients
    return unless reply?
 
      people_replied.each do |user|
        Recipient.create!(micropost_id: self.id, user_id: user.id)
      end
   end
 
    def reply?
      self.content.match( NICKNAME_REGEX )
    end

    def people_replied
      users = []
      self.content.clone.gsub!( NICKNAME_REGEX ).each do |nickname|
        user = User.find_by_nickname(nickname[1..-1])
        users << user if user
      end
      users.uniq
   end

end
