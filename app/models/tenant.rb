# frozen_string_literal: true

class Tenant < ApplicationRecord
  before_create :generate_api_key

  validates :name, presence: true

  def increment_request_count
    self.request_count += 1
    save!
  end

  private

    def generate_api_key
      self.api_key = SecureRandom.hex(16)
    end
end
