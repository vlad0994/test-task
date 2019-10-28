class ApplicationController < ActionController::Base
  include SessionsHelper
  include ErrorsHelper

  protect_from_forgery with: :null_session
  before_action :check_session

  private

  def check_session
    return if signed_in?

    @errors = generate_errors(User, session: 'Invalid session')
    render 'base/errors', status: 401
  end
end
