class CreateEventGroupings < ActiveRecord::Migration
  def change
    create_table :event_groupings do |t|
      t.belongs_to :event_group, index: true, foreign_key: true
      t.belongs_to :event_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
