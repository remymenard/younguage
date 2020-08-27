require 'csv'

puts '[1/4] Cleaning database...'
Flashcard.delete_all
List.delete_all
Word.delete_all
User.delete_all
puts '[1/4] Finished!'

puts '[2/4] Creating 1 fake user: Welcome Bob!'
user = User.new(email: 'bob@exemple.com', password: 'password')
user.save!
puts 'email: bob@exemple.com'
puts 'password: password'
puts '[2/4] Finished!'

puts "[3/4] Creating 1 fake list: 'All words'"
list = List.new(name: 'All words')
list.save!
puts '[3/4] Finished!'

puts '[4/4] Creating some fake words & flashcards...'
filepath = "#{Rails.root}/db/words.csv"
CSV.foreach(filepath) do |row|
  word = Word.new(word: row[0], translation: row[1], user: User.first)
  word.save!
  flashcard = Flashcard.new(word: word, list: List.first)
  flashcard.save!
  print '.'
end
puts ''
puts '[4/4] Finished!'
