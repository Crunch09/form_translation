require 'test_helper'

class ActiveRecordTest < ActiveSupport::TestCase

  test "#with_locale" do
    a = Article.create(subject: 'My subject', de_subject: 'Meine Überschrift')
    a.with_locale(:de) do
      assert_equal 'Meine Überschrift', a.subject
    end
    assert_equal 'My subject', a.subject
  end
end
