xml.rss :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.atom :link, nil, {
      :href => entries_url(:format => 'rss'),
      :rel => 'self',
      :type => 'application/rss+xml'
    }
    xml.title 'More Things Need To'
    xml.link 'http://morethingsneed.to/'
    xml.description 'More people need to subscribe to this RSS feed.'
    xml.language 'en'
    xml.pubDate @entries.first.created_at.to_s(:rfc822)
    xml.lastBuildDate @entries.last.created_at.to_s(:rfc822)
    
    @entries.each do |entry|
      xml.item do
        xml.title rss_title(entry)
        xml.description rss_description(entry)
        xml.pubDate entry.created_at.to_s(:rfc822)
        xml.link 'http://morethingsneed.to/' + entry.id.to_s
        xml.guid 'http://morethingsneed.to/' + entry.id.to_s
      end
    end
  end
end
