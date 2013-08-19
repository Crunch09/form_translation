module FormTranslation
  module ForModel
    def values_given_for? lng
      self.class.translated_attrs.each do |a|
        begin
          result = send "#{lng}_#{a}"
        rescue
          raise FormTranslation::Errors::InvalidColumnException,
            'You need to specify an existing and valid column to store your translations in.'
        end
        return true if result.present?
      end
      false
    end

    def translate! language = I18n.locale
      unless language == FormTranslation.default_language
        self.class.translated_attrs.each do |a|
          send "#{a}=", send("#{language}_#{a}")
        end
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def translate_me *methods
        store FormTranslation.translation_column
        methods.each do |m|
          FormTranslation.foreign_languages.each do |l|
            store_accessor FormTranslation.translation_column, "#{l}_#{m}".to_sym
          end
        end

        self.class.class_exec do
          define_method :translated_attrs do
            methods
          end

          define_method :form_translations do
            FormTranslation.foreign_languages.collect do |f|
              methods.collect do |m|
                "#{f}_#{m}".to_sym
              end
            end.flatten
          end
        end
      end
    end
  end
end
