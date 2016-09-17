class WelcomeController < ApplicationController

  before_action :authenticate_user, only: [:home]
  
  def home
  end

  private

  def authenticate_user
    redirect_to sign_in_path if signed_out?
  end
  
end
