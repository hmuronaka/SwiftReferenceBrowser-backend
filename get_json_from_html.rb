require 'nokogiri'
require 'pp'
require 'json'

# swiftの各クラスのdocumentページから、jsonを抜き出して保存する

dir = "swift"
yamls = []

Dir.glob("#{dir}/*.html") do |path|
  html = Nokogiri::HTML(File.read(path))
  html.xpath('//script[@id="bootstrap-data"]').each do |script|
    File.open("#{path}.json", "w") do |f|
      f.write script.content
    end
  end
end

