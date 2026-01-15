class CreateLandingPages < ActiveRecord::Migration
  def change
    create_table :landing_pages do |t|
      t.string :title, null: false
      t.text :header
      t.text :content
      t.text :footer
      t.text :video_embed
      t.boolean :display, default: true
      t.string :style, default: 'basic'
      t.string :layout, default: 'application'
      t.string :suggested_url
      t.string :slug, index: true
      t.string :image

      t.timestamps null: false
    end
  end
end
