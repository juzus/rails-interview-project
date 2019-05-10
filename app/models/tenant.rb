class Tenant < ActiveRecord::Base

  before_create :generate_api_key, :increment_request_count

  validates :name, presence: true

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end

  def increment_request_count
    request_count += 1
  end

end
