module Lists
  class NewService
    # attr_reader
    def initialize(list_name, user)
      @list_name = list_name
      @user      = user
    end

    def call
      new_list = List.new(name: @list_name, user: @user)
      new_list.save

      # creation des flashcards associees
      if @list_name == 'Révision du jour'
        Word.where(user: @user).order(:last_review).limit(30).each { |word| flashcard_new(word, new_list) }
      elsif @list_name == 'Nouveaux mots'
        Word.where(user: @user).order(created_at: :desc).limit(10).each { |word| flashcard_new(word, new_list) }
      end
    end

    private

    def flashcard_new(word, new_list)
      Flashcard.create(word: word, list: new_list, last_view: Time.now)
    end
  end
end
