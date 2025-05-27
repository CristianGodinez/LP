module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    current_sort = params[:sort]
    current_direction = params[:direction]

    new_direction = (current_sort == column && current_direction == "asc") ? "desc" : "asc"
    icon = if current_sort == column
             current_direction == "asc" ? "↑" : "↓"
           else
             ""
           end

    link_to "#{title} #{icon}".html_safe, request.query_parameters.merge(sort: column, direction: new_direction)
  end
end
