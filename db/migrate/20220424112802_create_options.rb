class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.references :question
      t.string :context
      t.boolean :is_correct, default: false

      t.timestamps
    end
  end
end
