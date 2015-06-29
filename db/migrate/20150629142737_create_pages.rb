class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text :content
      t.string :image
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
