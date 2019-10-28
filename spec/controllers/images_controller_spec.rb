require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  before do
    @user = create(:user)
    controller.sign_in(@user)
  end

  after do
    @user.destroy!
  end

  describe 'GET #index' do
    it 'returns http success' do
      5.times { @user.images.create(attributes_for(:image)) }

      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(assigns(:images).count).to be(5)
    end

    it 'should retur 401 status code for unauthenticated user' do
      cookies.permanent[:user_key] = nil
      controller.current_user = nil

      get :index, format: :json

      expect(response).to have_http_status(401)
      expect(response).to render_template('base/errors')
    end
  end

  describe 'POST #create' do
    it 'should create new image' do
      expect(@user.images.count).to be(0)

      post :create, format: :json, image: attributes_for(:image)

      expect(response).to have_http_status(:success)
      expect(@user.images.count).to be(1)
    end

    it 'should return 422 error for invalid image data' do
      post :create, format: :json, image: attributes_for(:image, width: 'str')

      expect(response).to have_http_status(422)
      expect(response).to render_template('base/errors')
    end

    it 'should retur 401 status code for unauthenticated user' do
      cookies.permanent[:user_key] = nil
      controller.current_user = nil

      post :create, format: :json, image: attributes_for(:image)

      expect(response).to have_http_status(401)
      expect(response).to render_template('base/errors')
    end
  end

  describe 'GET #show' do
    it 'should return selected image' do
      img = @user.images.create(attributes_for(:image))

      get :show, format: :json, id: img.id

      expect(response).to have_http_status(:success)
    end

    it 'should return 404 error for invalid urls' do
      get :show, format: :json, id: 100500

      expect(response).to have_http_status(404)
      expect(response).to render_template('base/errors')
    end

    it 'should retur 401 status code for unauthenticated user' do
      cookies.permanent[:user_key] = nil
      controller.current_user = nil

      img = @user.images.create(attributes_for(:image))

      get :show, format: :json, id: img.id

      expect(response).to have_http_status(401)
      expect(response).to render_template('base/errors')
    end
  end
end