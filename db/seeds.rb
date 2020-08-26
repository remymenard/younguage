require 'selenium-webdriver'
require 'open-uri'
require 'redcarpet'
require 'nokogiri'

Article.delete_all
Topic.delete_all

technology = Topic.create!(name: "technology")
future = Topic.create!(name: "future")
health = Topic.create!(name: "health")
work = Topic.create!(name: "work")
science = Topic.create!(name: "science")
business = Topic.create!(name: "business")
culture = Topic.create!(name: "culture")
food = Topic.create!(name: "food")
programming = Topic.create!(name: "programming")
design = Topic.create!(name: "design")
politics = Topic.create!(name: "politics")
human = Topic.create!(name: "human")
selfcare = Topic.create!(name: "selfcare")
startups = Topic.create!(name: "startups")

def scrap_articles_from_medium(topic)
  browser = Selenium::WebDriver.for :safari
  browser.get "https://medium.com/search?q=#{topic.name}"
  wait = Selenium::WebDriver::Wait.new(:timeout => 4)

  browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")
  sleep 0.5
  browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")

  all_a = browser.find_elements(:xpath => "//a").select do |element|
    element.text == 'Read more…'
  end
  all_a
end

def get_author_from_article(url)
  url = url.scan(/.+?(?=\/)/).join

  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('h1').first.text

  if html_doc.search('h1').first.text.nil?
    return 'unknown'
  else
    return html_doc.search('h1').first.text
  end
end

def convert_articles_to_markdown(articles)
  markdowns = []
  articles.each_with_index do |element, index|
    p url = element.attribute('href')
    p firstPart = url[0, url.index("?source")]
    `mediumexporter #{firstPart} > #{Rails.root}/lib/articles/#{index}.md`
    lines = File.open("#{Rails.root}/lib/articles/#{index}.md").to_a
    title = lines[1][2..-2]
    if lines.size < 10 && title != nil
      `rm #{Rails.root}/lib/articles/#{index}.md`
    else
      markdowns << {title: title, file_location: "#{Rails.root}/lib/articles/#{index}.md", url: url, author: get_author_from_article(url)}
    end
  end
  markdowns
end

def save_articles_to_db(markdowns, topic)
  renderer = Redcarpet::Render::HTML.new
  redcarpet = Redcarpet::Markdown.new(renderer)
  markdowns.each do |markdown|
    file     = File.open(markdown[:file_location]).read
    content   = redcarpet.render(file).delete("\n")

    # binding.pry

    Article.create!(title: markdown[:title], content: content, author: markdown[:author], url: markdown[:url], topic: topic)
  end
end

def generate_articles(topic)
  articles = scrap_articles_from_medium(topic)
  markdowns = convert_articles_to_markdown(articles)
  save_articles_to_db(markdowns, topic)
  FileUtils.rm_f Dir.glob("#{Rails.root}/lib/articles/*")
end

generate_articles(technology)
