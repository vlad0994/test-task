class UsersController < ApplicationController
  skip_before_action :check_session, only: [:create]

  def create
    @user = User.create
    sign_in(@user)

    render plain: 'OK'
  end
end
