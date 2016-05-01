class Application::UsersController < AuthenticatedController
  before_action :authorize, only: [:new, :edit, :update, :create, :destroy]

  def index
    @users = current_account.users
  end

  def new
    @user = current_account.users.build
  end

  def edit
    @user = current_account.users.find(params[:id])
  end

  def update
    @user = current_account.users.find(params[:id])

    if @user.update(user_update_params)
      redirect_to account_users_path
    else
      render :edit
    end
  end

  def create
    if User.invite!(user_params)
      redirect_to account_users_path
    else
      render :new
    end
  end

  def destroy
    @user = current_account.users.find(params[:id])
    @user.destroy
    redirect_to account_users_path
  end

  private

  def authorize
    current_user.owner?
  end

  def user_update_params
    params.
      require(:user).
      permit(:role)
  end

  def user_params
    params.
      require(:user).
      permit(:email, :role).
      merge(account_id: current_account.id)
  end
end
