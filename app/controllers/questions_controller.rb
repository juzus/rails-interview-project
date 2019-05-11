# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :verify_tenant, only: :index

  # Renders the template and initializes values for the HTML dashboard
  #
  def dashboard
    @questions = Question.all
    @answers = Answer.all
    @users = User.all
    @tenants = Tenant.all

    render :dashboard
  end

  # API method corresponding to the GET operation for a list of Questions
  #
  # Renders the list of non-private questions in JSON format
  #
  def index
    @questions = Question.where(private: false)

    render json: @questions, status: :ok
  end

  private

  # Verifies that the requester is registered as a tenant in the database
  # using the api_key passed in the request path
  #
  # Raises Tenant::AuthorizationError if the api_key isn't found
  # Otherwise, increments tenant request count
  #
  def verify_tenant
    tenant = Tenant.find_by(api_key: params[:api_key])

    raise TenantAuthorizationError if tenant.blank?

    tenant.increment_request_count
  end
end
