require 'simple_form'
require 'simple_form/form_builder'
require 'form_translation/languages_form_builder'

module FormTranslation
  class CustomFormBuilder < SimpleForm::FormBuilder

    def languagify &block
      return unless block_given?
      LanguagesFormBuilder.new(self).render &block
    end
  end

  begin
    require 'nested_form/builder_mixin'
    class NestedCustomFormBuilder < SimpleForm::FormBuilder
      include ::NestedForm::BuilderMixin
    end
  rescue LoadError
  end
end

