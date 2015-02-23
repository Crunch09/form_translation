module FormTranslation::SwitchLocale
  extend ActiveSupport::Concern

  def with_locale(loc, &block)
    self.class.with_locale(loc, &block)
  end

  included do
    @@_form_translation_locale = nil
    @@_form_translation_column = nil
  end

  module ClassMethods
    def with_locale(loc, &block)
      raise "unsupported language #{loc}" unless FormTranslation.languages.member? loc
      t = self.class_variable_get(:@@_form_translation_locale)
      @@_form_translation_locale = loc
      r = yield
      @@_form_translation_locale = t
      r
    end

    def form_translation_locale
      @@_form_translation_locale ||= nil
    end

    def translation_column(column)
      @@_form_translation_column = column
    end

    def get_translation_column
      @@_form_translation_column ||= nil
    end
  end
end

ActiveRecord::Base.send :include, FormTranslation::SwitchLocale
