DailyReport.delete_all

days = {
  Monday: 'L',
  Tuesday: 'M',
  Wednesday: 'M',
  Thursday: 'J',
  Friday: 'V',
  Saturday: 'S',
  Sunday: 'D'
}

days.each do |day, letter|
  daily_report = DailyReport.new(day: day, letter: letter)
  daily_report.save!
end

Lists::ResetService.new('Révision du jour').call
Lists::ResetService.new('Nouveaux mots').call
