module TemplatesHelper
  def show_street_address(template)
    template.street_address if template.street_address
  end

  def city_state_zip(template)
    "#{template.city}, #{template.state} #{template.zipcode}" if template.city && template.state && template.zipcode
  end

  def show_nickname(template)
    if current_page?(template_path(template))
      template.nickname
    else
      link_to template.nickname, template_path(template)
    end
  end

  def show_address(template)

    render partial: "templates/address", locals: { template: template }
  end

  def edit_delete_links(template)
    output = [
      link_to("Edit", edit_template_path(template), class: "btn btn-secondary"),
      link_to("Delete", template, method: :delete, class: "btn btn-danger", data: { confirm: "Are you sure you really want to delete this template" })
    ]
    safe_join(output)
  end

  def appointment_count(template)
    link_to pluralize(template.appointment_count, 'appointment'), template_path(template)
  end

  def template_value(template)
    number_to_currency(template.value) if template.value != 0
  end

  def client_count(template)
    link_to pluralize(template.client_count, 'client'), client_list_path(template)
  end


end
