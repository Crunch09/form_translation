require "form_translation/version"
require "form_translation/for_model"
require "simple_form/form_builder"

module FormTranslation

  mattr_accessor :default_language
  @@default_language = :en

  mattr_accessor :foreign_languages
  @@foreign_languages = []

  def self.config
    yield self
  end

  def self.languages
    [self.default_language].merge self.foreign_languages
  end
end
