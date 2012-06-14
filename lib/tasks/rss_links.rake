namespace :rss_links do
  desc 'Reload rss links data'
  task :reload => :environment do
    RssLink.find_each do |rss| 
      rss.reload_items!
      puts rss.link
    end
    puts "ok!"
  end
end
