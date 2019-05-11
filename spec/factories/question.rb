# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { FFaker::HipsterIpsum.sentence.gsub(/\.$/, "?") }
    asker { create(:user) }
  end
end
