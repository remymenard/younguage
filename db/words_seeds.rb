require 'csv'

puts '[1/3] Cleaning database...'
Flashcard.delete_all
Word.delete_all
User.delete_all
puts '[1/3] Finished!'

puts '[2/3] Creating a fake user...'
user = User.new(email: 'bob@exemple.com', password: 'password')
user.save!
puts '[2/3] Finished!'

puts '[3/3] Creating some fake words & flashcards...'
filepath = "#{Rails.root}/db/words.csv"
CSV.foreach(filepath) do |row|
  word = Word.new(word: row[0], translation: row[1])
  word.save!
  flashcard = Flashcard.new(word: word, user: User.first)
  flashcard.save!
end
puts '[3/3] Finished!'
