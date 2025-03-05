class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end

  def set_user
    @user = current_user
  end
end