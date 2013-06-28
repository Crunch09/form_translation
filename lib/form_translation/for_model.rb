module FormTranslation
  module ForModel
    def values_given_for? lng
      translated_attrs.each do |a|
        result = send "#{lng}_#{a}"
        return true if result.present?
      end
      false
    end

    def translate! language = I18n.locale
      unless language == :de
        translated_attrs.each do |a|
          send "#{a}=", send("#{language}_#{a}")
        end
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def translate_me *methods
        methods.each do |m|
          FormTranslation::foreign_languages.each do |l|
            store_accessor :translation, "#{l}_#{m}".to_sym
          end
        end

        define_method :translated_attrs do
          methods
        end
      end
    end
  end
end
