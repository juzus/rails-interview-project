# frozen_string_literal: true

class User < ApplicationRecord
  has_many :questions, inverse_of: :asker, dependent: :destroy
  has_many :answers,   inverse_of: :answerer, dependent: :destroy

  validates :name, presence: true

  def as_json(*)
    {
      id: id,
      name: name
    }
  end
end
