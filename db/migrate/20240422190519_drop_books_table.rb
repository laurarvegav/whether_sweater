class DropBooksTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :books
  end
end
