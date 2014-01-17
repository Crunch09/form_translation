class Article < ActiveRecord::Base
  include FormTranslation::ForModel

  translate_me :subject, :body, :publish_at
end
