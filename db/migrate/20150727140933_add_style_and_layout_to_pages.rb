class AddStyleAndLayoutToPages < ActiveRecord::Migration
  def change
    add_column :pages, :style, :string
    add_column :pages, :layout, :string
  end
end
