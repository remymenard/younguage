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
    end

    def call
      DailyReport.delete_all

      @days.each do |day, letter|
        daily_report = DailyReport.new(day: day, letter: letter)
        daily_report.save!
      end
    end
  end
end
