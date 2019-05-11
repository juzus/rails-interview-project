# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  # rubocop:disable Metrics/LineLength
  belongs_to :asker, inverse_of: :questions, class_name: 'User', foreign_key: 'user_id'
  # rubocop:enable Metrics/LineLength

  validates :title, presence: true

  # scope :public, -> { where(private: false) }

  def as_json(*)
    {
      title: title,
      asker: asker.as_json,
      answers: answers.as_json
    }
  end
end
