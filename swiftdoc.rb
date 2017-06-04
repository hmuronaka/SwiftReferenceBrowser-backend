require 'nokogiri'
require 'http'
require 'pry-byebug'
require 'pp'

# swiftの各クラスページをファイルに保存する

url = 'https://developer.apple.com/reference/swift'

doc = Nokogiri::HTML(HTTP.get(url).to_s)

classes = []
Dir.mkdir "swift" if not Dir.exists?("swift")

doc.xpath('//div[@class="task-symbols"]//a').each do |a|
	href = a.attributes["href"].value
	if href =~ /(\/[^\/]+)$/
		classes << {
			cls: a.content,
			url: url + $1
		}
	end
end

classes.each do |cls|
	html = HTTP.get(cls[:url])
	File.open("swift/" + cls[:cls] + ".html", "w") do |f|
		f.write(html)
	end
	puts "done..#{cls[:cls]}"
end
