require 'spec_helper'

describe RelationshipsController do
  
 
  
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  
  before(:each) do
     ActionMailer::Base.delivery_method = :test
     # ActionMailer::Base.perform_deliveries = true  
     ActionMailer::Base.deliveries.clear
  end

  before { sign_in user
           cookies[:remember_token] = user.remember_token }

  describe "creating a relationship with Ajax" do

    it "should increment the Relationship count" do
      expect do
        xhr :post,  relationships_path, relationship: { followed_id: other_user.id }
      end.to change(Relationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, relationships_path, relationship: { followed_id: other_user.id }
      response.should be_success
    end
  end

  describe "destroying a relationship with Ajax" do

    before { user.follow!(other_user) }
    let(:relationship) { user.relationships.find_by_followed_id(other_user) }

    it "should decrement the Relationship count" do
      expect do
        xhr :delete, relationship_path(relationship.id), id: relationship.id
      end.to change(Relationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, relationship_path(relationship.id), id: relationship.id
      response.should be_success
    end
  end
end 