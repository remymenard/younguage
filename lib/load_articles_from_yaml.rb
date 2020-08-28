articles = YAML.load(File.read(File.join(Rails.root, "lib/articles.yml")))

articles.each do |article|
  puts Article.create!(title: article[:title], content: article[:content], url: article[:url], author: article[:author], topic_id: article[:topic_id],)
end

