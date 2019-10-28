require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  after do
    @user.destroy!
  end

  subject { @user }

  it { should respond_to(:key) }

  describe "#key" do
    it "should be empty before creating user" do
      expect(@user.key).to be_falsey
    end

    it "should be generated auth key after creating user" do
      @user.save!

      expect(@user.key).not_to be_empty
    end
  end
end