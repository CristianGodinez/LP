class ProductosController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_producto, only: [:show, :edit, :update, :destroy]

  # GET /productos
  def index
    @productos = Producto.all
  end

  # GET /productos/:id
  def show
  end

  # GET /productos/new
  def new
    @producto = Producto.new
  end

  # POST /productos
  def create
    @producto = Producto.new(producto_params)
    if @producto.save
      redirect_to @producto, notice: "Producto creado correctamente."
    else
      render :new
    end
  end

  # GET /productos/:id/edit
  def edit
  end

  # PATCH/PUT /productos/:id
  def update
    if @producto.update(producto_params)
      redirect_to @producto, notice: "Producto actualizado correctamente."
    else
      render :edit
    end
  end

  # DELETE /productos/:id
  def destroy
    @producto.destroy
    redirect_to productos_path, notice: "Producto eliminado correctamente."
  end

  private

  def set_producto
    @producto = Producto.find(params[:id])
  end

  def producto_params
    params.require(:producto).permit(:nombre, :descripcion, :precio, :stock, :imagen)
  end

  def authorize_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Acceso restringido a administradores."
    end
  end
end
