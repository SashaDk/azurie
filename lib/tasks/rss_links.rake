namespace :rss_links do
  desc 'Reload rss links data'
  task :reload => :environment do
    Rails.logger = Logger.new(STDOUT)
    loop do
      RssLink.find_each do |rss| 
        rss.reload_items!
        puts rss.link
      end
      puts "ok!"
      sleep 3600
    end
  end
end
