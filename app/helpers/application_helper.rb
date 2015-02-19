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
    
    #red carpet
    def markdown(text)
  render_options = {
    # will remove from the output HTML tags inputted by user 
    filter_html:     true,
    # will insert <br /> tags in paragraphs where are newlines 
    # (ignored by default)
    hard_wrap:       false, 
    # hash for extra link options, for example 'nofollow'
    link_attributes: { rel: 'nofollow' },
    # more
    # will remove <img> tags from output
    no_images: true,
    # will remove <a> tags from output
    no_links: true,
    # will remove <style> tags from output
    no_styles: true
    # generate links for only safe protocols
    # safe_links_only: true
    # and more ... (prettify, with_toc_data, xhtml)
  }
  renderer = Redcarpet::Render::HTML.new(render_options)

  extensions = {
    #will parse links without need of enclosing them
    autolink:           true,
    # blocks delimited with 3 ` or ~ will be considered as code block. 
    # No need to indent.  You can provide language name too.
    # ```ruby
    # block of code
    # ```
    fenced_code_blocks: true,
    # will ignore standard require for empty lines surrounding HTML blocks
    lax_spacing:        true,
    # will not generate emphasis inside of words, for example no_emph_no
    no_intra_emphasis:  true,
    # will parse strikethrough from ~~, for example: ~~bad~~
    strikethrough:      true,
    # will parse superscript after ^, you can wrap superscript in () 
    superscript:        true,
    # will require a space after # in defining headers
    space_after_headers: false
  }
  Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
end
  
end
