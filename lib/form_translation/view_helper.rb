require 'simple_form'
begin
  require 'nested_form/builder_mixin'
rescue LoadError
end


module FormTranslation
  module ViewHelper
    def simple_translated_form_for(object, *args, &block)
      options = args.extract_options!
        simple_form_for(object,
          *(args << options.merge(builder: FormTranslation::CustomFormBuilder)),
          &block)
    end

    if defined?(FormTranslation::NestedCustomFormBuilder)
      def simple_translated_nested_form_for(object, *args, &block)
        options = args.extract_options!
        simple_nested_form_for(object,
          *(args << options.merge(builder: FormTranslation::NestedCustomFormBuilder)),
          &block)
      end
    end
  end
end
