class ResetLists < ApplicationJob
  queue_as :default

  def perform(args = ['Révision du jour', 'Nouveaux mots'])
    args.each do |arg|
      Lists::ResetService.new(arg).call
    end
  end
end
