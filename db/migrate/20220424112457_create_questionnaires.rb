class CreateQuestionnaires < ActiveRecord::Migration[6.1]
  def change
    create_table :questionnaires do |t|
      t.references :user
      t.float :point
      t.boolean :is_completed, default: false

      t.timestamps
    end
  end
end
