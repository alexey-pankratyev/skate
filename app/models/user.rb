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
  
  # include ActiveRecord::Transitions 

    attr_accessible :name, :email, :password, :password_confirmation, :nickname, :follower_notifications, :password_reset_token, :state

    has_secure_password
    has_many :microposts , dependent: :destroy
    has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed
    has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
    has_many :followers, through: :reverse_relationships, source: :follower
    has_many :replies, foreign_key: "to_id", class_name: "Micropost"
    # has_many :DirectMessages, foreign_key: "sender_id"
   

    before_save { email.downcase! }
    # before_save { generate_token(:remember_token) }
    before_save :create_remember_token
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i   
    validates :email, presence: true,
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
               # unless:  :password_is_not_being_updated?

    validates :password_confirmation, presence: true
               # unless: :password_is_not_being_updated?

  state_machine :state do
    state :inactive
    state :active

    event :activate do
      transition :active => :inactive
    end
  end



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

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  private

    def create_remember_token
       self.remember_token = SecureRandom.urlsafe_base64
    end
    
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
     end while User.exists?(column => self[column])
    end

    def password_is_not_being_updated?
       self.id && self.password.blank?
    end

  
end
