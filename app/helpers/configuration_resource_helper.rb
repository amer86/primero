module ConfigurationResourceHelper

  include AttachmentHelper

  def resource_edit_field(object, field, label_key, type, required=false, disabled=false)
    field_id = "#{object.class.name.underscore}_#{field}"
    name = "#{object.class.name.underscore}[#{field}]"
    value = object.send(field)
    label_text = I18n.t(label_key)
    tag_helper = (type == 'date') ? 'text_field_tag' : "#{type}_tag"

    content_tag :div, class: 'row' do
      concat(content_tag(:div, class: 'medium-3 columns'){
        content_tag(:span, class: 'tool-tip-label'){
          label_tag(field_id, label_text, class: 'key inline')
        }
      })
      concat(content_tag(:div, class: 'medium-8 columns'){
        if type == 'file_field' && field == 'logo'
          show_logo_upload(object, field_id, type, tag_helper)
        else
          self.send(tag_helper, name, h(value), id: field_id, autocomplete: 'off',
            class: ((type == 'date') ? 'form_date_field' : ''), disabled: disabled)
        end
      })
      #TODO: This should be replaced with Foundation required field components
      concat(content_tag(:div, class: 'medium-1 columns'){
        content_tag(:span, '*', class: 'required') if required
      })
    end
  end

  def resource_show_field(object, field, label_key)
    label_text = I18n.t(label_key)
    value = object.send(field)

    content_tag :div, class: 'row' do
      concat(content_tag(:div, class: 'medium-4 columns'){
        label_tag(field, label_text, class: 'key')
      })
      concat(content_tag(:div, class: 'medium-8 columns'){
        if field == 'logo'
          img = send("#{object.class.name.underscore.downcase}_logo_url", object, object['logo_key'])
          concat(content_tag(:span, image_tag(img), class: value))
        else
          content_tag(:span, h(value), class: 'value')
        end
      })
    end
  end

  def show_logo_upload(object, field_id, type, tag_helper)
    concat(self.send(tag_helper, "agency[upload_logo]logo", id: "#{field_id}", autocomplete: 'off',
          class: ((type == 'date') ? 'form_date_field' : '')))

    if !object.new_record? && object['logo_key']
      img = send("#{object.class.name.underscore.downcase}_logo_url", object.id, object['logo_key'])
      concat(content_tag(:span, image_tag(img)))
    end
  end
end