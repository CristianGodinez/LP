class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def authorize_admin!
    redirect_to compras_path, alert: "Acceso restringido a administradores." unless current_user&.admin?
  end
end
