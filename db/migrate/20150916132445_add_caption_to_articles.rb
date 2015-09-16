class AddCaptionToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :caption, :string
  end
end
