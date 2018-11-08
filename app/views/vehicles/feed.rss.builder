#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Codingfish"
    xml.author "Achim Fischer"
    xml.description "Software-Development, Mobiles Devices, Photography"
    xml.link "https://www.codingfish.com"
    xml.language "en"

    for article in @vehicles
      xml.item do
        
      end
    end
  end
end