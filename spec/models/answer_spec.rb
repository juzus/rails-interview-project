# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject { create(:answer) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it { should belong_to(:question) }
  it { should belong_to(:answerer) }

  describe '.body' do
    it { should validate_presence_of(:body) }
  end

  describe '#as_json' do
    let(:answer) { Answer.first }
    let(:answer_hash) { answer.as_json.with_indifferent_access }
    let(:expected_hash) do
      {
        'body' => answer.body,
        'answerer' => { 'id' => answer.answerer.id, 'name' => answer.answerer.name }
      }
    end

    before do
      create(:answer)
    end

    it 'returns the correct hash which will be encoded to JSON' do
      expect(answer_hash).to eq(expected_hash)
    end
  end
end
