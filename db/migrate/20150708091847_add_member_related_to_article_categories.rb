class AddMemberRelatedToArticleCategories < ActiveRecord::Migration
  def change
    add_column :article_categories, :member_related, :boolean, default: false
  end
end
