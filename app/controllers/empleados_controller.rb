class EmpleadosController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_empleado, only: [:edit, :update, :destroy]

  def index
    @empleados = User.where(admin: false)
  end

  def new
    @empleado = User.new
  end

  def create
    @empleado = User.new(empleado_params)
    @empleado.admin = false
    if @empleado.save
      redirect_to empleados_path, notice: "Empleado creado exitosamente."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @empleado.update(empleado_params)
      redirect_to empleados_path, notice: "Empleado actualizado exitosamente."
    else
      render :edit
    end
  end

  def destroy
    if @empleado.compras.exists?
      redirect_to empleados_path, alert: "No se pudo eliminar: el empleado tiene ventas registradas."
    else
      @empleado.destroy
      redirect_to empleados_path, notice: "Empleado eliminado correctamente."
    end
  end



  private

  def set_empleado
    @empleado = User.find(params[:id])
  end

  def empleado_params
    params.require(:user).permit(:nombre, :apellido, :email, :telefono, :password)
  end

  def authorize_admin!
    redirect_to root_path, alert: "Acceso restringido a administradores." unless current_user&.admin?
  end
end
