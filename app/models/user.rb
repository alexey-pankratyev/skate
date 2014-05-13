# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  salt            :string(255)
#  admin           :boolean          default(FALSE)
#  password_digest :string(255)
#  remember_token  :string(255)
#  nickname        :string(255)
#


class User < ActiveRecord::Base  

    attr_accessible :name, :email, :password, :password_confirmation, :nickname

    has_secure_password
    has_many :microposts , dependent: :destroy
    has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed
    has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
    has_many :followers, through: :reverse_relationships, source: :follower
    has_many :replies, foreign_key: "to_id", class_name: "Micropost"

    before_save { email.downcase! }
    before_save :create_remember_token
 
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i   
    validates :email, #presence: true,
             format: { with: email_regex },
             uniqueness:  { case_sensitive: false }

    uname_regex = /^[a-z](\w*[a-z0-9])*$/i
    validates :nickname, presence: true,
                         length: { maximum: 15 },
                         format: { with: uname_regex },
                         uniqueness: { case_sensitive: false }

    validates :name,  presence: true,
                    length:    { maximum: 50 }

    

    validates :password, presence: true,
               length: { within: 6..40 }

    validates :password_confirmation, presence: true    

  def feed
     Micropost.from_users_followed_by_including_replies(self) 
  end    

  def handle
   "@#{nickname.downcase}"
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
