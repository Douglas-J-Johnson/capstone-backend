class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.integer :date
      t.string :text

      t.timestamps
    end
  end
end
