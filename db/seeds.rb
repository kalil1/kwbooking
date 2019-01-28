# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
require 'open-uri'

demo = []
image = []
nicknames = []

page = Nokogiri::HTML(open("https://www.w3schools.com/w3css/w3css_templates.asp"))
img_links = page.css("img")
demo_links = page.css("div.w3-content a[style='width:98.5%']")
nicknames_ = page.css("div.w3-panel h3")

nicknames_.each{|link| nicknames << "#{link.text}" }
img_links.each{|link| image << "https://www.w3schools.com/w3css/#{link['src']}" }
demo_links.each{|link| demo << "https://www.w3schools.com/w3css/#{link['href']}" }
demo = demo.reject {|v| demo.index(v).odd?}


image.count.times do |num|
template = Template.create(nickname: nicknames[num], src: image[num], iframe: demo[num], price: 500)
template.save
end
p "Done"
