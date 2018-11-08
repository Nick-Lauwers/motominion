#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.instruct! 'xml-stylesheet', href: 'text.css', type: 'rss.css'
xml.rss "xmlns:g" => "http://base.google.com/ns/1.0", "version" => "2.0" do
  xml.channel do

  end
end