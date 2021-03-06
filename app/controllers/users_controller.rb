class UsersController < Clearance::UsersController

  def create
    # byebug
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthday, :email, :password)
  end

end
