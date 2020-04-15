class CreateAnalyses < ActiveRecord::Migration[6.0]
  def change
    create_table :analyses do |t|
      t.string :raw_results
      t.references :entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
