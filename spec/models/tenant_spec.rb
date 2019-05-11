# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tenant, type: :model do
  subject { create(:tenant) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'has generated an api_key for the tenant' do
    expect(subject.api_key).to match(/^[0-9A-F]+$/i)
  end

  describe '.name' do
    it { should validate_presence_of(:name) }
  end

  describe '#increment_request_count' do
    let(:tenant) { create(:tenant) }

    it 'updates the request_count' do
      tenant.increment_request_count
      expect(tenant.request_count).to eq 1
    end
  end
end
