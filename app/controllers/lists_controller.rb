class ListsController < ApplicationController
  def show
    @list = List.find(params[:id])
    @flashcards = @list.flashcards
    @percentage = percentage(@list)
  end

  def index
    @today = Date.today.strftime('%A')
    @days = DailyReport.order(:id)
    @today_report = DailyReport.find_by(day: @today)

    @revision_du_jour = List.find_by(name: 'Révision du jour')
    @rdj_percentage = percentage(@revision_du_jour)
    @rdj_cards_left = @revision_du_jour.flashcards.where(mastered: false).count

    @nouveaux_mots = List.find_by(name: 'Nouveaux mots')
    @nm_percentage = percentage(@nouveaux_mots)
    @nm_cards_left = @nouveaux_mots.flashcards.where(mastered: false).count
  end

  def nouveaux_mots_new
    new_list = new('Nouveaux mots')
    Word.order(created_at: :desc).limit(10).each do |word|
      Flashcard.create(word: word, list: new_list, last_view: Time.now)
    end
    redirect_to list_path(new_list)
  end

  def revision_du_jour_new
    new_list = new('Révision du jour')
    Word.order(:last_review).limit(30).each do |word|
      Flashcard.create(word: word, list: new_list, last_view: Time.now)
    end
    redirect_to list_path(new_list)
  end

  private

  def new(name)
    list = List.find_by(name: name)
    list.flashcards.each { |flashcard| flashcard.destroy }
    list.destroy

    new_list = List.new(name: name)
    new_list.save
    return new_list
  end

  def percentage(list)
    total_cards_num = list.flashcards.count.to_f
    if total_cards_num != 0
      return (list.flashcards.where(mastered: true).count.to_f / total_cards_num * 100).round
    else
      return 0
    end
  end
end
