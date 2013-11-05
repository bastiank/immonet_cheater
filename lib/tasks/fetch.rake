namespace :immonet do
  desc "Fetch mails from immonet@arrowsoft.de and contact immonet object owner"
  task :fetch => :environment do
    ImmonetMail.fetch
  end
end
