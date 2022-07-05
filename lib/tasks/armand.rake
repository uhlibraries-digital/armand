namespace :armand do
  desc "Reindex the repository objects"
  task reindex: :environment do
    ReindexJob.perform_later
  end
end