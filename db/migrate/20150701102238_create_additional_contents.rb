class CreateAdditionalContents < ActiveRecord::Migration
  def change
    create_table :additional_contents do |t|
      t.string :area
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
