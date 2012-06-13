xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Azurie | Media"
    xml.description "Azurie is 'knowledge media' for the worldwide entrepreneurial community. We slash through the Web's jungle of information on entrepreneurship to reveal the top experts, the brightest ideas, and the edgiest products from around the world."
    xml.link briefings_url
    @briefings.each do |b|
      xml.item do
        xml.title b.title
        xml.description "#{truncate(strip_tags(b.description), :length => 800, :separator => "\n")} #{link_to "(#{t 'briefings.briefing.learn_more'})", b}"
        xml.pubDate b.created_at.to_s(:rfc822)
        xml.link briefing_url(b)
        xml.guid briefing_url(b)
      end
    end
  end
end
