module DailyReports
  class ResetService
    def initialize
      @days = {
        Monday: 'L',
        Tuesday: 'M',
        Wednesday: 'M',
        Thursday: 'J',
        Friday: 'V',
        Saturday: 'S',
        Sunday: 'D'
      }
      @users = User.all
    end

    def call
      DailyReport.delete_all

      @users.each do |user|
        @days.each do |day, letter|
          daily_report = DailyReport.new(user: user, day: day, letter: letter)
          daily_report.save!
        end
      end
    end
  end
end
