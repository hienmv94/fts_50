module ApplicationHelper
  def full_title page_title = ""
    base_title = t "home_page.full_title"
    page_title.empty? ? base_title: "#{page_title} | #{base_title}"
  end

  def add_fields_answer f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    tmpl = f.fields_for(association, new_object,
      child_index: "new_#{association}") do |b|
      render "#{association.to_s.singularize}_form", f: b
    end
    tmpl = tmpl.gsub /(?<!\n)\n(?!\n)/, " "
    return "<script> var #{association.to_s}_form = '#{tmpl.to_s}' </script>"
      .html_safe
  end
end
