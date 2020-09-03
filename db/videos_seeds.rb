require "selenium-webdriver"
require "webdrivers"

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument("--headless")
browser = Selenium::WebDriver.for :chrome
Topic::NAMES.each do |name|

  browser.get "https://www.youtube.com/results?search_query=#{name}+english&sp=EgIoAQ%253D%253D"

  sleep 0.5

  all_url = browser.find_elements(:id, "video-title").map do |title|
    title.attribute("href")

  end
end
