class CreateFaqs < ActiveRecord::Migration[7.0]
  def change
    create_table :faqs do |t|
      t.string :question
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
