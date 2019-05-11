# frozen_string_literal: true

class Question < ActiveRecord::Base

  has_many :answers, dependent: :destroy
  belongs_to :asker, class_name: 'User', foreign_key: 'user_id'

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
