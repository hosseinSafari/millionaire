class CreateQuestionnaireQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questionnaire_questions do |t|
      t.references :question
      t.references :questionnaire
      t.boolean :is_used, default: false

      t.timestamps
    end
  end
end
