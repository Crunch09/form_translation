require "form_translation/version"
require "form_translation/engine"
require "form_translation/for_model"
require "form_translation/custom_form_builder"
require "form_translation/errors"
require "form_translation/active_record"

module FormTranslation

  mattr_accessor :default_language
  @@default_language = :de

  mattr_accessor :foreign_languages
  @@foreign_languages = [:en]

  mattr_accessor :translation_column
  @@translation_column = :translation

  def self.config
    yield self
  end

  def self.languages
    (Array(self.default_language) + Array(self.foreign_languages)).uniq
  end
end
