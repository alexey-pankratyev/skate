# == Schema Information
#
# Table name: direct_messages
#
#  id           :integer          not null, primary key
#  content      :string(255)
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class DirectMessage < ActiveRecord::Base

   attr_accessible :content, :recipient_id, :sender_id
   
   belongs_to :sender, :class_name => User.name
   belongs_to :recipient, :class_name => User.name

   validates :content, :presence => true
   validates :sender, :presence => true
   validates :recipient, :presence => true

end
