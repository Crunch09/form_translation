module SimpleForm
  class FormBuilder < ActionView::Helpers::FormBuilder
    def div_tabs &block
      rnd = SecureRandom.hex(8)
      @template.content_tag(:div, '') do
        divs = ''
        divs += @template.content_tag(:ul, class: 'nav nav-tabs') do
          li_content rnd
        end
        divs += @template.content_tag(:div, class: 'tab-content') do
          tab_content rnd, &block
        end
        divs.html_safe
      end
    end

    def languagify &block
      send("div_tabs", &block)
    end

    private

    def li_content rnd
      FormTranslation.languages.collect do |l|
        listyle = ''
        listyle = 'empty_tab' if l != :de && !object.values_given_for?(l)

        @template.content_tag(:li, class: listyle) do
          @template.content_tag(:a, href: "##{l}_#{rnd}") do
            l.to_s
          end
        end
      end.join.html_safe
    end

    def tab_content rnd
      FormTranslation.languages.collect do |l|
        @template.content_tag(:div, class: 'tab-pane', id: "#{l}_#{rnd}") do
          if l == :de
            yield
          else
            instance_exec do
              alias :old_input :input
              @l = l
              def input(attribute_name, options = {}, &block)
                attribute_name = "#{@l}_#{attribute_name}"
                old_input(attribute_name, options, &block)
              end
              yield
              alias :input :old_input
            end
          end
        end
      end.join.html_safe
    end
  end
end
