class ListsController < ApplicationController
  def show

    @list = List.find_by(name: 'Révision du jour')

    # if List.find_by(name: 'Révision du jour').nil?
    #   @list = List.new(name: 'Révision du jour')
    #   Word.order(:last_review).limit(30).each do |word|
    #     Flashcard.new(word: word, list: @list)
    #   end
    # end

    @percentage = percentage(@list)
  end

  def index
    @today = Date.today.strftime('%A')
    @days = DailyReport.all

    @revision_du_jour = List.find_by(name: 'Révision du jour')
    @rdj_percentage = percentage(@revision_du_jour)
    @rdj_cards_left = @revision_du_jour.flashcards.where(mastered: false).count

    @new_cards = List.find_by(name: '20 derniers mots')
    @nc_percentage = percentage(@new_cards)
    if @new_cards.flashcards.empty?
      @nc_cards_left = 20
    else
      @nc_cards_left = @new_cards.flashcards.where(mastered: false).count
    end
  end

  def revision_du_jour_destroy
    list = List.find_by(name: 'Révision du jour')
    list.destroy
  end

  def revision_du_jour_create
    list = List.new(name: 'Révision du jour')
    Word.order(:last_review).limit(30).each do |word|
      Flashcard.create(word: word, list: list)
    end
    list.save
  end

  private

  def percentage(list)
    total_cards_num = list.flashcards.count.to_f
    if total_cards_num != 0
      return (list.flashcards.where(mastered: true).count.to_f / total_cards_num * 100).round
    else
      return 0
    end
  end
end
