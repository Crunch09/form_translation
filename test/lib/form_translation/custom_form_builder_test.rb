require 'test_helper'

class CustomFormBuilderTest < ActiveSupport::TestCase
  setup do
    @template = Object.new
    @template.class.send(:include, ActionView::Context)
    @template.extend ActionView::Helpers::FormHelper
    @template.extend ActionView::Helpers::DateHelper
    @template.extend ActionView::Helpers::FormOptionsHelper
    @template.extend ActionView::Helpers::FormTagHelper
    a = Article.new
    cfb = FormTranslation::CustomFormBuilder.new('article', a, @template, {})
    @p = Proc.new{|form_builder, symbol, options={}| form_builder.input symbol, options}
    @lfb = FormTranslation::LanguagesFormBuilder.new(cfb)
    @template.class.send(:define_method, :controller){ nil }
    @lfb.language = :de

  end

  test "creates text input" do
    translated_content = @p.call(@lfb, :subject)
    assert_equal("<div class=\"input string optional article_de_subject\"><label class=\"string optional\" for=\"article_de_subject\">De subject</label><input class=\"string optional\" id=\"article_de_subject\" name=\"article[de_subject]\" type=\"text\" /></div>", translated_content)
    assert_equal translated_content.gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject).gsub(/Subject/, 'subject')
  end

  test "creates checkbox" do
    assert_equal @p.call(@lfb, :subject, as: :boolean).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :boolean).gsub(/Subject/, 'subject')
  end

  test "creates email input" do
    assert_equal @p.call(@lfb, :subject, as: :email).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :email).gsub(/Subject/, 'subject')
  end

  test "creates url input" do
    assert_equal @p.call(@lfb, :subject, as: :url).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :url).gsub(/Subject/, 'subject')
  end

  test "creates tel input" do
    assert_equal @p.call(@lfb, :subject, as: :tel).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :tel).gsub(/Subject/, 'subject')
  end

  test "creates password input" do
    assert_equal @p.call(@lfb, :subject, as: :password).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :password).gsub(/Subject/, 'subject')
  end

  test "creates search input" do
    assert_equal @p.call(@lfb, :subject, as: :search).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :search).gsub(/Subject/, 'subject')
  end

  test "creates textarea" do
    assert_equal @p.call(@lfb, :subject, as: :text).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :text).gsub(/Subject/, 'subject')
  end

  test "creates file input" do
    assert_equal @p.call(@lfb, :subject, as: :file).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :file).gsub(/Subject/, 'subject')
  end

  test "creates hidden field" do
    assert_equal @p.call(@lfb, :subject, as: :hidden).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :hidden).gsub(/Subject/, 'subject')
  end

  test "creates number input" do
    assert_equal @p.call(@lfb, :subject, as: :integer).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :integer).gsub(/Subject/, 'subject')

    assert_equal @p.call(@lfb, :subject, as: :float).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :float).gsub(/Subject/, 'subject')

    assert_equal @p.call(@lfb, :subject, as: :decimal).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :decimal).gsub(/Subject/, 'subject')
  end

  test "creates range input" do
    assert_equal @p.call(@lfb, :subject, as: :range).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, as: :range).gsub(/Subject/, 'subject')
  end

  test "creates datetime select" do
    assert_equal @p.call(@lfb, :publish_at, as: :datetime).gsub(/[dD]e[_\s]{1}publish[_\s]{1}at/,'publish_at'),
                 @p.call(@lfb.form_builder, :publish_at, as: :datetime).gsub(/Publish at/, 'publish_at')
  end

  test "creates date select" do
    assert_equal @p.call(@lfb, :publish_at, as: :date).gsub(/[dD]e[_\s]{1}publish[_\s]{1}at/,'publish_at'),
                 @p.call(@lfb.form_builder, :publish_at, as: :date).gsub(/Publish at/, 'publish_at')
  end

  test "creates time select" do
    assert_equal @p.call(@lfb, :publish_at, as: :time).gsub(/[dD]e[_\s]{1}publish[_\s]{1}at/,'publish_at'),
                 @p.call(@lfb.form_builder, :publish_at, as: :time).gsub(/Publish at/, 'publish_at')
  end

  test "creates select" do
    assert_equal @p.call(@lfb, :subject, collection: 10..30).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, collection: 10..30).gsub(/Subject/, 'subject')
  end

  test "creates radio buttons" do
    assert_equal @p.call(@lfb, :subject, collection: 10..30, as: :radio_buttons).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, collection: 10..30, as: :radio_buttons).gsub(/Subject/, 'subject')
  end

  test "creates checkboxes" do
    assert_equal @p.call(@lfb, :subject, collection: 10..30, as: :check_boxes).gsub(/[dD]e[_\s]{1}subject/,'subject'),
                 @p.call(@lfb.form_builder, :subject, collection: 10..30, as: :check_boxes).gsub(/Subject/, 'subject')
  end
end
