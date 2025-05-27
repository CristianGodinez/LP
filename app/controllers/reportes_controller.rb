class ReportesController < ApplicationController
  require "prawn/table"

  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_venta, only: [:edit, :update, :destroy]

def index
  @productos = Producto.all
  @clientes = Compra.distinct.pluck(:cliente).compact.sort
  @empleados = User.select(:id, :nombre, :apellido).order(:nombre)

  @ventas = filtrar_ventas.order("compras.#{sort_column} #{sort_direction}")
end


  def edit
  end

  def update
    original_cantidad = @venta.cantidad
    if @venta.update(venta_params)
      diferencia = @venta.cantidad - original_cantidad
      @venta.producto.increment!(:stock, -diferencia)
      redirect_to reportes_path, notice: "Venta actualizada correctamente."
    else
      redirect_to reportes_path, alert: "Error al actualizar la venta."
    end
  end

  def destroy
    @venta.producto.increment!(:stock, @venta.cantidad)
    @venta.destroy
    redirect_to reportes_path, notice: "Venta eliminada correctamente."
  end

  def exportar_pdf
    @productos = Producto.all
    @ventas = filtrar_ventas.order("compras.#{sort_column} #{sort_direction}")

    pdf = Prawn::Document.new
    logo_path = Rails.root.join("app/assets/images/logo_cirene.png")
    pdf.image(logo_path.to_s, width: 80, height: 80, at: [pdf.bounds.right - 90, pdf.bounds.top]) if File.exist?(logo_path)

    pdf.move_down 20
    pdf.text "Reporte de Ventas", size: 24, style: :bold, align: :center
    pdf.move_down 30

    data = [["Producto", "Cantidad", "Precio Total", "Fecha", "Cliente", "Empleado"]]
    @ventas.each do |venta|
      data << [
        venta.producto.nombre,
        venta.cantidad,
        "$#{venta.precio_total}",
        venta.created_at.strftime("%d/%m/%Y"),
        venta.cliente,
        venta.user ? "#{venta.user.nombre} #{venta.user.apellido}" : "—"
      ]
    end

    pdf.table(data, header: true, row_colors: ["F0F0F0", "FFFFFF"], width: 540)
    pdf.move_down 10
    pdf.text "Total recaudado: $#{@ventas.sum(&:precio_total)}", size: 14, style: :bold

    send_data pdf.render, filename: "reporte_ventas.pdf", type: "application/pdf", disposition: "inline"
  end

  def exportar_excel
    @productos = Producto.all
    @ventas = filtrar_ventas.order("compras.#{sort_column} #{sort_direction}")
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=reporte_ventas.xlsx"
      }
    end
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "Acceso restringido a administradores." unless current_user&.admin?
  end

  def filtrar_ventas
    ventas = Compra.includes(:producto, :user)
    ventas = ventas.where(producto_id: params[:producto_id]) if params[:producto_id].present?

    if params[:fecha_inicio].present? && params[:fecha_fin].present?
      inicio = Date.parse(params[:fecha_inicio])
      fin = Date.parse(params[:fecha_fin])
      ventas = ventas.where(created_at: inicio.beginning_of_day..fin.end_of_day)
    end

    ventas = ventas.where("cliente LIKE ?", "%#{params[:cliente]}%") if params[:cliente].present?

    if params[:empleado].present?
      nombre, apellido = params[:empleado].split(" ", 2)
      ventas = ventas.joins(:user).where(users: { nombre: nombre })
      ventas = ventas.where("users.apellido LIKE ?", "%#{apellido}%") if apellido.present?
    end

    ventas
  end


  def set_venta
    @venta = Compra.find(params[:id])
  end

  def venta_params
    params.require(:compra).permit(:cantidad, :cliente)
  end

  private

  def sort_column
    %w[cantidad cliente precio_total created_at].include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
