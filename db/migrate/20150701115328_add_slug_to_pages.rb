class AddSlugToPages < ActiveRecord::Migration
  def change
    add_column :pages, :slug, :string
    add_column :pages, :suggested_url, :string
  end
end
