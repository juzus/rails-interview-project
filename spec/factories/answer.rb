# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    question
    answerer { create(:user) }
    body { FFaker::HipsterIpsum.sentence }
  end
end
