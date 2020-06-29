namespace :sync do
  namespace :recruitable do
    desc 'Evally Recruitable - synchronization'

    task users: :environment do
      admin = User.admin.first

      if admin.present?
        User.find_each.map { |user| V2::Sync::UserSyncService.new(user, admin).perform }
      else
        puts "\nAdmin account does not exist, please create one to run synchronization"
      end
    end
  end
end
