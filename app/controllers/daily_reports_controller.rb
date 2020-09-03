class DailyReportsController < ApplicationController
  def mark_a_day_as_done
    if List.find(params[:list_id]).name == 'Révision du jour'
      daily_report = DailyReport.where(user: current_user).find_by(day: Date.today.strftime('%A'))
      daily_report.state = 'done'
      daily_report.save
    end

    redirect_to lists_path
  end
end
