class RssLink < ActiveRecord::Base
  serialize :items_data
  serialize :shares_data
  validates :link, :presence => true, :uniqueness => true, :format => { :with => /^http:\/\/(.*)/, :allow_blank => true }
  scope :top, :order => :rank.desc

  def items
    begin
      if updated_at < EXPIRES.ago || items_data.nil? || shares_data.nil?
        self.items_data = get_items
        self.shares_data = get_shares
        self.rank = shares_data.map{|k,s| s['shares'].to_i || s['likes'].to_i || 0 }.inject(0, :+)
        save!
      end
      items_data.each do |k,v|
        item = shares_data.select {|kk,vv| k[0,kk.length] == kk }.first.last rescue nil
        shares = item['shares'].to_i  || item['likes'].to_i || 0 rescue 0
        v.title = "(#{shares} likes) #{v.title}"
        v.instance_variable_set("@shares", shares)
      end
      items_data.values
    rescue
      Rails.logger.info "\n\n#{'='*20} BAD_FEED_ERROR: #{link} #{'='*20}\n\n"
      []
    end
  end

private 
  EXPIRES = 10.minutes  

  def get_items
    Rails.logger.info link
    #items = RestClient.get(link) {|response, request, result| SimpleRSS.parse(result.body).items }
    items = Feedzirra::Feed.fetch_and_parse(link).entries
    Hash[items.first(10).map{|i| [i.url, i] }]
  end

  def get_shares
    RestClient.get("http://graph.facebook.com?ids=#{get_items().keys.map{|i| URI.escape(i)}.join(',')}"){|r,rr,rrr| JSON.parse gunzip(rrr.body)}
  end

  def gunzip(string)
    ActiveSupport::Gzip.decompress(string) rescue string
  end 
end
