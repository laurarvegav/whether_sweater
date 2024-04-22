class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :isbn, array: true, default: []
      t.text :publisher, array: true, default: []

      t.timestamps
    end
  end
end
