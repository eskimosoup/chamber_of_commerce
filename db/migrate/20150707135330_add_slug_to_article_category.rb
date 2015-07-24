class AddSlugToArticleCategory < ActiveRecord::Migration
  def change
    add_column :article_categories, :slug, :string
    add_index :article_categories, :slug
  end
end
