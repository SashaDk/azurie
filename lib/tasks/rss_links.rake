namespace :rss_links do
  desc 'Reload rss links data'
  task :reload => :environment do
    RssLink.order(:updated_at).limit(2).each do |rss| 
      rss.reload_items!
      puts rss.link
    end
    puts "ok!"
  end
end
