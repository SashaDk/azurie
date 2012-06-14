class RssLink < ActiveRecord::Base
  serialize :items_data
  serialize :shares_data
  validates :link, :presence => true, :uniqueness => true, :format => { :with => /^(http|feed):\/\/(.*)/, :allow_blank => true }
  scope :top, :order => :rank.desc
  after_create :reload_items!

  def items
    items_data.each do |k,v|
      item = shares_data.select {|kk,vv| k[0,kk.length] == kk }.first.last rescue nil
      shares = item['shares'].to_i  || item['likes'].to_i || 0 rescue 0
      v.title = "(#{shares} likes) #{v.title}"
      v.instance_variable_set("@shares", shares)
    end
    items_data.values
  end

  def reload_items! 
    self.items_data = get_items
    self.shares_data = get_shares
    self.rank = shares_data.map{|k,s| s['shares'].to_i || s['likes'].to_i || 0 }.inject(0, :+)
    save!
  end

private 
  def get_items
    feed = Feedzirra::Feed.fetch_and_parse(self.link)
    begin
      items = feed.entries.first(10).map do |i| 
        i.author = "<a href='#{feed.url}'>#{feed.title}</a>"
        i.title = "#{i.title} via #{feed.title}"
        i.url = RestClient.head(i.url){|r,rr,rrr| r.headers[:location] || i.url} rescue i.url
        [i.url, i] 
      end
      Hash[items]
    rescue
      Rails.logger.info "\n\n#{'='*20} BAD_FEED_ERROR: #{link} #{'='*20}\n\n"
      {}
    end
  end

  def get_shares
    RestClient.get("http://graph.facebook.com?ids=#{items_data.keys.compact.map{|i| URI.escape(i.gsub(/(\?.*)|(#.*)/,''))}.join(',')}"){|r,rr,rrr| JSON.parse gunzip(rrr.body)}
  end

  def gunzip(string)
    ActiveSupport::Gzip.decompress(string) rescue string
  end 
end
