require 'simple_form'

module SimpleForm
  module ActionViewExtensions
    module FormHelper
      alias :orig_simple_form_for :simple_form_for
      def simple_form_for(object, *args, &block)
        options = args.extract_options!
        orig_simple_form_for(object,
          *(args << options.merge(builder: FormTranslation::CustomFormBuilder)),
          &block)
      end
    end
  end
end
