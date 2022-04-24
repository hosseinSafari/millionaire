class CreateQuestionnaires < ActiveRecord::Migration[6.1]
  def change
    create_table :questionnaires do |t|
      t.references :user
      t.string :point

      t.timestamps
    end
  end
end
