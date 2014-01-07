class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.datetime :publish_at
      t.string :subject
      t.text :body
      t.text :translation

      t.timestamps
    end
  end
end
