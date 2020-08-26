# require 'csv'
# require 'selenium-webdriver'
# require 'json'
# require 'open-uri'
# require 'redcarpet'
# require 'nokogiri'

# # puts "Which theme do you want to scrape ?"
# # theme = gets.chomp

# # browser = Selenium::WebDriver.for :chrome
# # browser.get "https://medium.com/search?q=#{theme}"

# # wait = Selenium::WebDriver::Wait.new(:timeout => 10)


# # browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")
# # sleep 0.5

# # browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")

# # all_a = browser.find_elements(:xpath => "//a").select do |element|
# #   element.text == 'Read more…'
# # end


# # csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
# # filepath    = "#{Rails.root}/lib/articles.csv"

# # CSV.open(filepath, 'wb', csv_options) do |csv|
# #   all_a.each_with_index do |element, index|
# #     url = element.attribute('href')
# #     p firstPart = url[0, url.index("?source")]
# #     csv << [firstPart]
# #     `mediumexporter #{firstPart} > #{Rails.root}/lib/articles/#{index}.md`
# #     lines = File.open("#{Rails.root}/lib/articles/#{index}.md").to_a
# #     `rm #{Rails.root}/lib/articles/#{index}.md` if lines.size < 10
# #   end
# # end

# # renderer = Redcarpet::Render::HTML.new
# # markdown = Redcarpet::Markdown.new(renderer)
# # file     = File.open("#{Rails.root}/lib/articles/1.md").read
# # result   = markdown.render(file).delete("\n")
# # p result

# # string = "https://medium.com/mydfs/the-pleasures-and-sorrows-of-fantasy-sports-4151c232ab79"
# # url = string.scan(/.+?(?=\/)/).join

# # html_file = open(url).read
# # html_doc = Nokogiri::HTML(html_file)

# # p html_doc.search('h1').first.text
