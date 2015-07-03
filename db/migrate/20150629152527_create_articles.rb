class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.belongs_to :article_category, index: true, foreign_key: true
      t.text :summary
      t.text :content
      t.string :image
      t.date :date
      t.boolean :display, default: true
      t.timestamps null: false
    end
  end
end
