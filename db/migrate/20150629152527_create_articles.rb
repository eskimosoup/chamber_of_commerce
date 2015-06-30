class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.belongs_to :category, index: true, foreign_key: true
      t.text :summary
      t.text :content
      t.string :image
      t.date :date

      t.timestamps null: false
    end
  end
end
