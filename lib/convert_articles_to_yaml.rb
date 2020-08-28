require 'yaml'


articles = Article.all
yaml = articles.map do |article|
  {
    url: article.url,
    title: article.title,
    content: article.content,
    author: article.content,
    topic_id: article.topic_id
  }
end
path = File.join(Rails.root, "lib/")
file_name = "articles.yml"
file_path = File.join(path, file_name)
File.open(file_path, "w") { |file| file.write(yaml.to_yaml) }
