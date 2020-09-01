class DailyReportsController < ApplicationController
  def mark_a_day_as_done

    daily_report = DailyReport.find_by(day: Date.today.strftime('%A'))
    daily_report.state = 'done'
    daily_report.save

    list = List.find_by(name: 'Révision du jour')
    list.flashcards.each { |flashcard| flashcard.destroy }
    list.destroy

    new_list = List.new(name: 'Révision du jour')
    new_list.save
    Word.order(:last_review).limit(30).each do |word|
      Flashcard.create(word: word, list: new_list)
    end

    redirect_to lists_path
  end
end
