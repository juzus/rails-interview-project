# frozen_string_literal: true

module Rescuable
  extend ActiveSupport::Concern

  def handle_invalid_tenant
    logger.info(
      message: 'Consumer used invalid tenant api key',
      api_key: params[:api_key]
    )

    render status: :forbidden, json: { error: 'Invalid tenant api key' }
  end
end
