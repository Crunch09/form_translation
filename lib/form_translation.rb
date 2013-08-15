require "form_translation/version"
require "form_translation/for_model"
require "form_translation/custom_form_builder"

module FormTranslation

  mattr_accessor :default_language
  @@default_language = :de

  mattr_accessor :foreign_languages
  @@foreign_languages = [:en]

  def self.config
    yield self
  end

  def self.languages
    (Array(self.default_language) + Array(self.foreign_languages)).uniq
  end
end
