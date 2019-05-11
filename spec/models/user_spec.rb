# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  describe '.name' do
    it { should validate_presence_of(:name) }
  end

  describe '#as_json' do
    let(:user) { User.first }
    let(:user_hash) { user.as_json.with_indifferent_access }
    let(:expected_hash) do
      {
        'id' => user.id,
        'name' => user.name
      }
    end

    before do
      create(:user)
    end

    it 'returns the correct hash which will be encoded to JSON' do
      expect(user_hash).to eq(expected_hash)
    end
  end
end
