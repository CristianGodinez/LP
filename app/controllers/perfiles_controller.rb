class PerfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: "Perfil actualizado exitosamente."
    else
      render :edit
    end
  end

  private

  def user_params
    permitted = [:nombre, :apellido, :email, :telefono]
    permitted += [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit(permitted)
  end
end
