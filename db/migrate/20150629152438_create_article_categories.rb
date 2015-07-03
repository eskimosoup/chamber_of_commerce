class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
