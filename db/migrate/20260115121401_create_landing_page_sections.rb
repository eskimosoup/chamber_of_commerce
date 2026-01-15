class CreateLandingPageSections < ActiveRecord::Migration
  def change
    create_table :landing_page_sections do |t|
      t.belongs_to :landing_page, index: true, foreign_key: true
      t.integer :position, default: 0
      t.string :area, null: false, index: true
      t.string :title
      t.text :content
      t.string :image
      t.string :button_link
      t.string :button_text
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
