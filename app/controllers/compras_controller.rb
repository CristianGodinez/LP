class ComprasController < ApplicationController
  before_action :authenticate_user!

  # GET /compras
  def index
    @productos = Producto.all
    @compra = Compra.new
  end

  # GET /compras/new
  def new
    @compra = Compra.new
    @productos = Producto.all
  end

  # POST /compras
  def create
    @compra = Compra.new(compra_params)
    @compra.user = current_user

    producto = Producto.find(@compra.producto_id)
    @compra.precio_unitario = producto.precio
    @compra.precio_total = @compra.cantidad * producto.precio

    if @compra.save
      redirect_to compras_path, notice: "Venta registrada exitosamente."
    else
      @productos = Producto.all
      render :index
    end
  end

  private

  def compra_params
    params.require(:compra).permit(:producto_id, :cantidad, :cliente)
  end
end
