class AddButtonToAdditionalContents < ActiveRecord::Migration
  def change
    add_column :additional_contents, :button_link, :string
    add_column :additional_contents, :button_text, :text
  end
end
