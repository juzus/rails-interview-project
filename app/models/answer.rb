# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  # rubocop:disable Metrics/LineLength
  belongs_to :answerer, inverse_of: :answers, class_name: 'User', foreign_key: 'user_id'
  # rubocop:enable Metrics/LineLength

  validates :body, presence: true

  def as_json(*)
    {
      body: body,
      answerer: answerer.as_json
    }
  end
end
