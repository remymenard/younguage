require "selenium-webdriver"
require "webdrivers"
require "open-uri"
require "redcarpet"
require "nokogiri"
require 'yaml'

Article.delete_all
Topic.delete_all

def scrap_articles_from_medium(topic)
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  browser = Selenium::WebDriver.for :chrome, options: options
  browser.get "https://medium.com/search?q=#{topic.name}"
  wait = Selenium::WebDriver::Wait.new(:timeout => 4)

  browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")
  sleep 0.5
  browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")

  all_a = browser.find_elements(:xpath => "//a").select do |element|
    element.text == "Read more…"
  end
  all_dates = browser.find_elements(:xpath => "//dates")
  # browser.close
  [all_a, all_dates]
end

def get_author_from_article(url)
  url = url.scan(/.+?(?=\/)/).join

  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  unless html_doc.search("h1").first
    return "unknown"
  else
    return html_doc.search("h1").first.text
  end
end

def convert_articles_to_markdown(articles)
  markdowns = []
  articles[0].each_with_index do |element, index|
    url = element.attribute("href")
    puts firstPart = url[0, url.index("?source")]
    `mediumexporter #{firstPart} > #{Rails.root}/lib/articles/#{index}.md`
    lines = File.open("#{Rails.root}/lib/articles/#{index}.md").to_a
    begin
      title = lines[1][2..-2]
    rescue
      return
    end
    `touch #{Rails.root}/lib/articles/#{index}.1.md`
    File.open("#{Rails.root}/lib/articles/#{index}.1.md", "w") do |out_file|
      File.foreach("#{Rails.root}/lib/articles/#{index}.md").with_index do |line, line_number|
        out_file.puts line if line_number > 1
      end
    end

    if lines.size < 10 && title != nil && url != nil
      `rm #{Rails.root}/lib/articles/#{index}.md`
      `rm #{Rails.root}/lib/articles/#{index}.1.md`
    else
      # pry
      markdowns << { title: title, file_location: "#{Rails.root}/lib/articles/#{index}.1.md", url: url, author: get_author_from_article(url) }
    end
  end
  markdowns
end

def save_articles_to_db(markdowns, topic)
  renderer = Redcarpet::Render::HTML.new
  redcarpet = Redcarpet::Markdown.new(renderer)
  articles = []
  return nil if markdowns.nil?
  markdowns.each do |markdown|
    file = File.open(markdown[:file_location]).read
    content = redcarpet.render(file).delete("\n")
    # binding.pry
    article = Article.create!(title: markdown[:title], content: content, author: markdown[:author], url: markdown[:url], topic: topic)
    articles << article
  end
end

def convert_articles_to_yaml
  articles = Article.all
  yaml = articles.map do |article|
    {
      url: article.url,
      title: article.title,
      content: article.content,
      author: article.author,
      topic: article.topic.name
    }
  end
  path = File.join(Rails.root, "lib/")
  file_name = "articles.yml"
  file_path = File.join(path, file_name)
  File.open(file_path, "w") { |file| file.write(yaml.to_yaml) }
end

def load_articles_from_yaml
  articles = YAML.load(File.read(File.join(Rails.root, "lib/articles.yml")))
  articles.each do |article|
    Topic.where(name: article[:topic])
    Article.create!(title: article[:title], content: article[:content], url: article[:url], author: article[:author], topic_id: Topic.where(name: article[:topic]).pluck(:id).first)
  end
end

def generate_articles(topic)
  articles = scrap_articles_from_medium(topic)
  markdowns = convert_articles_to_markdown(articles)
  save_articles_to_db(markdowns, topic)
  FileUtils.rm_f Dir.glob("#{Rails.root}/lib/articles/*")
  convert_articles_to_yaml
end

if File.file?(File.join(Rails.root, "lib/articles.yml"))
  Topic::NAMES.each do |name|
    topic = Topic.create!(name: name)
  end
  load_articles_from_yaml
else
  Topic::NAMES.each do |name|
    topic = Topic.create!(name: name)
    puts "generating articles for #{name}"
    generate_articles(topic)
  end
end
