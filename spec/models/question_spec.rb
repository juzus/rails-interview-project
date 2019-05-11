# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { create(:question) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to(:asker) }

  describe '.title' do
    it { should validate_presence_of(:title) }
  end

  describe '.asker' do
    context "when asker isn't provided" do
      subject { build(:question, asker: nil) }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end

      it 'has the expected error message' do
        subject.valid?
        expect(subject.errors[:asker]).to include 'must exist'
      end
    end
  end

  describe '#as_json' do
    let(:question) { Question.first }
    let(:answer_1) { question.answers.first }
    let(:answer_2) { question.answers.last }
    let(:question_hash) { question.as_json.with_indifferent_access }
    let(:expected_hash) do
      {
        'title' => question.title,
        'asker' => { 'id' => question.asker.id, 'name' => question.asker.name },
        'answers' => [
          {
            'body' => answer_1.body,
            'answerer' => { 'id' => answer_1.answerer.id, 'name' => answer_1.answerer.name }
          },
          {
            'body' => answer_2.body,
            'answerer' => { 'id' => answer_2.answerer.id, 'name' => answer_2.answerer.name }
          }
        ]
      }
    end

    before do
      create(:question)
      create(:answer, question: question)
      create(:answer, question: question)
    end

    it 'returns the correct hash which will be encoded to JSON' do
      expect(question_hash).to eq(expected_hash)
    end
  end
end
