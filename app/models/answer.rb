# frozen_string_literal: true

class Answer < ActiveRecord::Base

  belongs_to :question
  belongs_to :answerer, class_name: 'User', foreign_key: 'user_id'

  validates :body, presence: true

  def as_json(*)
    {
      body: body,
      answerer: answerer.as_json
    }
  end
end
