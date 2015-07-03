class RenameCategoriesToArticleCategories < ActiveRecord::Migration
  def change
    rename_table :categories, :article_categories
    rename_column :articles, :category_id, :article_category_id
  end
end
