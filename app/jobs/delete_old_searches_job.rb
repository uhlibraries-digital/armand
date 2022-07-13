class DeleteOldSearchesJob < ActiveJob::Base

  def perform
    Search.where(['created_at < ? AND user_id IS NULL', 20.minutes.ago]).delete_all
  end

end