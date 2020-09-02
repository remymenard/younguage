require 'csv'

puts '[1/4] Cleaning database...'
Flashcard.delete_all
List.delete_all
Word.delete_all
DailyReport.delete_all
User.delete_all
puts '[1/4] Finished!'

puts '[2/4] Creating 1 fake user: Welcome Bob!'
user = User.new(email: 'bob@exemple.com', password: 'password')
user.save!
puts 'email: bob@exemple.com'
puts 'password: password'
puts '[2/4] Finished!'

puts '[3/4] Creating some fake words'
filepath = "#{Rails.root}/db/words.csv"
CSV.foreach(filepath) do |row|
  User.all.each do |user|
    word = Word.new(word: row[0], translation: row[1], user: user)
    word.save!
  end
end
puts '[3/4] Finished!'

puts '[4/4] Creating a daily report per user and some basics lists...'
DailyReports::ResetService.new.call
User.all.each do |user|
  Lists::ResetService.new('Révision du jour', user).call
  Lists::ResetService.new('Nouveaux mots', user).call
end
puts '[4/4] Finished!'
