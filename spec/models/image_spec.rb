require 'rails_helper'

RSpec.describe Image, type: :model do
  before do
    @user = create(:user)
    @image = Image.new(attributes_for(:image, user: @user))
  end

  after do
    @image.destroy!
    @user.destroy!
  end

  subject { @image }

  it { should respond_to(:width) }
  it { should respond_to(:height) }
  it { should respond_to(:picture) }
  it { should respond_to(:user_id) }

  it "user_id can't be empty" do
    img = build(:image)
    expect(img).not_to be_valid

    img.user = @user
    expect(img).to be_valid

    img.destroy!
  end

  describe "#width" do
    it "should be a number" do
      @image.width = 'str'
      expect(@image).not_to be_valid

      @image.width = 100
      expect(@image).to be_valid
    end

    it "should be a greater than 0" do
      @image.width = -100
      expect(@image).not_to be_valid
    end

    it "can be blank" do
      @image.width = nil
      expect(@image).to be_valid
    end
  end

  describe "#height" do
    it "should be a number" do
      @image.height = 'str'
      expect(@image).not_to be_valid

      @image.height = 100
      expect(@image).to be_valid
    end

    it "should be a greater than 0" do
      @image.height = -100
      expect(@image).not_to be_valid
    end

    it "can be blank" do
      @image.height = nil
      expect(@image).to be_valid
    end
  end

  describe "#picture" do
    it "can't be empty" do
      img = Image.new(attributes_for(:image, picture: nil))
      expect(img).not_to be_valid

      img.destroy!
    end
  end

  describe "#resize" do
    it "should return resized MiniMagick::Image object" do
      mini_magick_obj = @image.resize

      expect(mini_magick_obj).to be_kind_of(MiniMagick::Image)
    end
  end
end