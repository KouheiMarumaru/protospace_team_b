class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @prototypes = @user.prototypes
    user = User.find(params[:id])
    @prototypes = user.prototypes.page(params[:page]).per(5).order("created_at DESC")
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to :root, notice: 'Your user infomation was successfully updated'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :position,
      :profile,
      :occupation,
      :avatar
    )
  end
end
