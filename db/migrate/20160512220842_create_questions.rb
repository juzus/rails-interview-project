# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.boolean :private, default: false, index: true
      t.references :user, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
