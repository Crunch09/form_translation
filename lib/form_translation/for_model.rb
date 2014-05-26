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

        _translated_attrs = methods.dup.freeze
        define_singleton_method :translated_attrs do
          _translated_attrs
        end

        _form_translations = FormTranslation.foreign_languages.collect do |f|
          _translated_attrs.collect do |m|
            "#{f}_#{m}".to_sym
          end
        end.flatten.freeze
        define_singleton_method :form_translations do
          _form_translations
        end
        create_translated_getters(methods)
      end # translate_me

      def create_translated_getters(methods)
        mod = Module.new
        methods.each do |nam|
          mod.send(:define_method, nam) do
            return super() unless self.class.form_translation_locale
            return super() if self.class.form_translation_locale == FormTranslation.default_language
            a = self.send "#{self.class.form_translation_locale}_#{nam}"
            a.presence || self[nam]
          end # define_method
        end #methods.each

        prepend mod
      end # create_translated_getters

      def translation_names_for *attributes
        Array(attributes).flatten.collect do |a|
          FormTranslation.foreign_languages.collect do |f|
            "#{f}_#{a}".to_sym
          end
        end.flatten
      end
    end
  end
end
