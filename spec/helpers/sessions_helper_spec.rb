require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ImagesHelper. For example:
#
# describe ImagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  before do
    @user = create(:user)
  end

  after do
    @user.destroy!
  end

  describe "#sign_in" do
    it "should authenticate user" do
      helper.sign_in(@user)

      expect(helper.instance_variable_get(:@current_user)).to be(@user)
    end
  end

  describe "#current_user" do
    it "should return current user after sign in" do
      helper.sign_in(@user)

      expect(helper.current_user).to be(@user)
    end
  end

  describe "#signed_in?" do
    it "should return false for unauthenticated user" do
      expect(helper.signed_in?).to be_falsey
    end

    it "should return true for authenticated user" do
      helper.sign_in(@user)

      expect(helper.signed_in?).to be_truthy
    end
  end
end