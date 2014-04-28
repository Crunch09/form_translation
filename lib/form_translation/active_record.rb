module FormTranslation::SwitchLocale

  def with_locale(loc, &block)
    self.class.with_locale(loc, &block)
  end

  def self.included(by)
    by.send :extend, FormTranslation::SwitchLocale::ClassMethods
  end

  module ClassMethods
    def with_locale(loc, &block)
      raise "unsupported language #{loc}" unless FormTranslation.languages.member? loc
      t = @@_form_translation_locale
      @@_form_translation_locale = loc.to_sym
      yield
      @@_form_translation_locale = t
    end
  end
end

ActiveRecord::Base.send :include, FormTranslation::SwitchLocale
