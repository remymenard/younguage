

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
    new_list = Lists::ResetService.new('Nouveaux mots').call
    redirect_to list_path(new_list)
  end

  def revision_du_jour_new
    new_list = Lists::ResetService.new('Révision du jour').call
    redirect_to list_path(new_list)
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
