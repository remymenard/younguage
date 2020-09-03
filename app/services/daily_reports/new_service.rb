module DailyReports
  class NewService
    def initialize(user)
      @days = {
        Monday: 'L',
        Tuesday: 'M',
        Wednesday: 'M',
        Thursday: 'J',
        Friday: 'V',
        Saturday: 'S',
        Sunday: 'D'
      }
      @user = user
    end

    def call
      @days.each do |day, letter|
        daily_report = DailyReport.new(user: @user, day: day, letter: letter)
        daily_report.save!
      end
    end
  end
end
