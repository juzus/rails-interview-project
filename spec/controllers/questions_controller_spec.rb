# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  it { is_expected.to use_before_action(:verify_tenant) }

  describe '#dashboard' do
    subject { get :dashboard }

    before do
      create_list(:question, 5)
      create_list(:answer, 15)
      create_list(:tenant, 20)
      create_list(:user, 20)
    end

    let(:questions) { Question.all }
    let(:answers) { Answer.all }
    let(:tenants) { Tenant.all }
    let(:users) { User.all }

    it 'renders the dashboard template' do
      expect(subject).to render_template(:dashboard)
    end

    it 'assigns questions for the view' do
      subject
      expect(assigns(:questions)).to eq questions
    end

    it 'assigns users for the view' do
      subject
      expect(assigns(:users)).to eq users
    end

    it 'assigns answers for the view' do
      subject
      expect(assigns(:answers)).to eq answers
    end

    it 'assigns tenants for the view' do
      subject
      expect(assigns(:tenants)).to eq tenants
    end
  end

  describe '#index' do
    context 'with a valid tenant' do
      let(:tenant) { create(:tenant) }
      subject { get :index, params: { api_key: tenant.api_key } }

      it 'increments the tenant request count' do
        subject
        expect(tenant.reload.request_count).to eq 1
      end

      context 'when no questions exist' do
        it { is_expected.to have_http_status(:ok) }

        it 'returns the correct body' do
          expect(JSON.parse(subject.body)).to eq []
        end
      end

      context 'when both private and non-private questions exist' do
        before do
          FactoryBot.create(:question, private: false)
          FactoryBot.create(:question, private: false)
          FactoryBot.create(:question, private: true)
        end

        let(:question_hash) { Question.where(private: false).as_json }

        it { is_expected.to have_http_status(:ok) }

        it 'returns the correct body' do
          questions = subject.body
          expect(questions).to eq question_hash.to_json
        end

        it { is_expected.to have_http_status(:ok) }
      end
    end

    context 'with an invalid tenant' do
      subject { get :index, params: { api_key: 'm4D3y0ul00K' } }

      it 'returns unauthorized status and message' do
        subject
        expect(response.status).to eq 403
        expect(JSON.parse(response.body)['error']).to eq 'Invalid tenant api key'
      end
    end
  end
end
