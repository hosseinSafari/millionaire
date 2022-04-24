class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :option
      t.references :questionnaire

      t.timestamps
    end
  end
end
