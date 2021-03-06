# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  def job_id
    provider_job_id || super
  end
end
