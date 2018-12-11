class ChangeLayoutDefaultOnArticles < ActiveRecord::Migration
  def change
    change_column :articles, :layout, :string, default: 'full_image'
  end
end
