module FormTranslation
  class LanguagesFormBuilder

    attr_accessor :form_builder, :language
    delegate :object, :template, :find_wrapper, to: :form_builder

    def initialize(form_builder)
      @form_builder = form_builder
    end

    def render(&block)
      rnd = SecureRandom.hex(8)
      template.content_tag(:div, '') do
        divs = ''
        divs += template.content_tag(:ul, class: 'nav nav-tabs form-translation-tabs') do
          li_content rnd
        end
        divs += template.content_tag(:div, class: 'tab-content') do
          language_tabs rnd, &block
        end
        divs.html_safe
      end
    end


    def association(*args)
      raise "not implemented!"
    end

    def input(attribute_name, options={}, &block)
      # @language is set and not default.
      options = @defaults.deep_dup.deep_merge(options) if @defaults
      input   = form_builder.send(:find_input, attribute_name, options, &block)
      input.instance_variable_set("@attribute_name", "#{self.language}_#{input.attribute_name}".to_sym)

      chosen =
        if name = options[:wrapper] || form_builder.send(:find_wrapper_mapping, input.input_type)
          name.respond_to?(:render) ? name : SimpleForm.wrapper(name)
        else
          form_builder.wrapper
        end

      chosen.render input
    end

    private

    def li_content rnd
      FormTranslation.languages.collect do |l|
        listyle = 'empty_tab' if l != FormTranslation.default_language && !object.values_given_for?(l)
        listyle = 'active' if l == FormTranslation.default_language

        template.content_tag(:li, class: (listyle || '')) do
          template.link_to(
            "#{flag_for(l)} #{l}".html_safe,
            "##{l}_#{rnd}", data: {toggle: 'tab'})
        end
      end.join.html_safe
    end

    def language_tabs rnd
      FormTranslation.languages.collect do |l|
        @language = l
        active = 'active' if l == FormTranslation.default_language
        template.content_tag(:div, class: "tab-pane #{active}", id: "#{l}_#{rnd}") do
          if l == FormTranslation.default_language
            yield form_builder
          else
            yield self
          end
        end
      end.join.html_safe
    end

    def flag_for language
      flag_shortcut = language
      flag_shortcut = 'gb' if flag_shortcut.to_sym == :en
      template.content_tag(:span, '', class: "flag-icon flag-icon-#{flag_shortcut}")
    end
  end
end
