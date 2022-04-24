class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.references :question
      t.string :context

      t.timestamps
    end
  end
end
