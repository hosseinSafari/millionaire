class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :context
      t.float :point

      t.timestamps
    end
  end
end
