puts '[1/5] Cleaning database...'
Flashcard.delete_all
List.delete_all
Word.delete_all
DailyReport.delete_all
Order.delete_all
Subscription.delete_all
User.delete_all
puts '[1/5] Finished!'

puts '[2/5] Creating 1 fake user: Welcome Bob!'
user = User.new(email: 'bob@exemple.com', password: 'password')
user.save!
puts 'email: bob@exemple.com'
puts 'password: password'
puts '[2/5] Finished!'

puts '[3/5] Creating some fake words'
User.all.each do |user|
  Words::NewService.new(user).call
end
puts '[3/5] Finished!'

puts '[4/5] Creating a daily report per user and some basics lists...'
DailyReports::ResetService.new.call
User.all.each do |user|
  Lists::ResetService.new('Révision du jour', user).call
  Lists::ResetService.new('Nouveaux mots', user).call
end
puts '[4/5] Finished!'

puts '[5/5] Creating the PREMIUM subscription...'
Subscriptions::NewService.new.call
puts '[5/5] Finished!'
