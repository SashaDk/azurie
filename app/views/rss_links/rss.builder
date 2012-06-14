xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Azurie Top News"
    xml.description "Best news, popularity sorted"
    xml.link rss_rss_links_path
    @items.each do |item|
      xml.item do
        xml.title "#{item.title}"
        xml.description item.summary || item.content
        xml.author item.author
        #xml.pubDate item.published
        xml.link item.url
        xml.guid item.url
      end
    end
  end
end
