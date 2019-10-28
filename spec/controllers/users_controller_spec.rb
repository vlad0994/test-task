require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  after do
    User.destroy_all
  end

  describe 'POST #create' do
    it 'creates new user' do
      expect(User.all.count).to be(0)

      post :create

      expect(response).to have_http_status(:success)
      expect(User.all.count).to be(1)
    end
  end
end