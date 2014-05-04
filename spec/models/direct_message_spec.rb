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

require 'spec_helper'

describe DirectMessage do
  pending "add some examples to (or delete) #{__FILE__}"
end
