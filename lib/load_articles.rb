require 'csv'
require 'selenium-webdriver'
require 'json'
require 'open-uri'

puts "Which theme do you want to scrape ?"
theme = gets.chomp

browser = Selenium::WebDriver.for :chrome
browser.get "https://medium.com/search?q=#{theme}"

wait = Selenium::WebDriver::Wait.new(:timeout => 10)


browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")
sleep 0.5

browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")

all_a = browser.find_elements(:xpath => "//a").select do |element|
  element.text == 'Read more…'
end


csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = "#{Rails.root}/lib/articles.csv"

CSV.open(filepath, 'wb', csv_options) do |csv|
  all_a.each_with_index do |element, index|
    url = element.attribute('href')
    p firstPart = url[0, url.index("?source")]
    csv << [firstPart]
    `mediumexporter #{firstPart} > #{Rails.root}/lib/articles/#{index}.md`
    lines = File.open("#{Rails.root}/lib/articles/#{index}.md").to_a
    `rm #{Rails.root}/lib/articles/#{index}.md` if lines.size < 10
  end
end


# url = "https://unmediumed.com/#{articles_url[0]}"
# `mediumexporter https://medium.com/@xdamman/my-10-day-meditation-retreat-in-silence-71abda54940e > #{Rails.root}/lib/articles/medium_post2.md`
# p user_serialized.gsub!(/\n/, '<br/>')
