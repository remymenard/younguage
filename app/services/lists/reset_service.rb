module Lists
  class ResetService
    # attr_reader
    def initialize(list_name, user)
      @list_name = list_name
      @user      = user
    end

    def call
      new_list = new(@list_name) # suppression de la liste existante et creation d'une nouvelle

      # creation des flashcards associees
      if @list_name == 'Révision du jour'
        Word.where(user: @user).order(:last_review).limit(30).each { |word| flashcard_new(word, new_list) }
      elsif @list_name == 'Nouveaux mots'
        Word.where(user: @user).order(created_at: :desc).limit(10).each { |word| flashcard_new(word, new_list) }
      end

      new_list
    end

    private

    def new(list_name)
      list = List.where(user: @user).find_by(name: list_name)
      unless list.nil?
        list.flashcards.each { |flashcard| flashcard.destroy }
        list.destroy
      end

      new_list = List.new(name: list_name, user: @user)
      new_list.save
      return new_list
    end

    def flashcard_new(word, new_list)
      Flashcard.create(word: word, list: new_list, last_view: Time.now)
    end
  end
end
