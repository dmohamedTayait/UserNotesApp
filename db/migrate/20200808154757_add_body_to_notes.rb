class AddBodyToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :body, :string
  end
end
