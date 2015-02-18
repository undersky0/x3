module ApplicationHelper
  def title(page_title)
    content_for(:title) {page_title}
  end
    def message_person(mailbox_name, message)
    mailbox_name == 'inbox' ? message.sender : message.recipient_list.join(', ')
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end


  def resource_class
  devise_mapping.to
end

  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success" # Green
      when :error
        "alert-danger" # Red
      when :alert
        "alert-warning" # Yellow
      when :notice
        "alert-info" # Blue
      else
        [flash_type.to_sym] || flash_type.to_s
    end
  end
  
    def quid(price)
    if price==0
      return "FREE"
    else
    return number_to_currency(price, :unit=> "£")
    end
  end  
  
  def link_to_with_icon(icon_css, title, url, options = {})
    icon = content_tag(:i, nil, class: icon_css)
    title_with_icon = icon << ' ' << title
    link_to(title_with_icon, url, options)
  end

  def toggle_button_to(icon_css, title, url, urloff,titleoff, options = {})
    
    on_options = {
      'data-remote' => true,
      'data-type' => 'script',
      'data-method' => 'GET',
      class: options[:on]
    }

    off_options = {
      'data-remote' => true,
      'data-type' => 'script',
      'data-method' => 'GET',
      class: options[:off]
    }

    on_link = link_to_with_icon(icon_css, title, url, on_options)
    off_link = link_to_with_icon(icon_css, titleoff, urloff, off_options)

    on_link << off_link
  end
      
    def invite_css(invite)
    'joined' if !invite.users_joined.where(user_id: current_user.id).empty?
    end
    
    def is_admin?
      return current_user.try(:admin?)
    end
  
end
