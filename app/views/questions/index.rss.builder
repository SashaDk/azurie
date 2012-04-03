xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Azurie | Q&As"
    xml.description "Azurie is 'knowledge media' for the worldwide entrepreneurial community. We slash through the Web's jungle of information on entrepreneurship to reveal the top experts, the brightest ideas, and the edgiest products from around the world."
    xml.link questions_url
    @questions.each do |q|
      xml.item do
        xml.title q.title
        xml.description q.description
        xml.pubDate q.created_at.to_s(:rfc822)
        xml.link question_url(q)
        xml.guid question_url(q)
      end
    end
  end
end
