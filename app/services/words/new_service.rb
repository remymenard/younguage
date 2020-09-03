module Words
  class NewService
    def initialize(user)
      @user = user
      @now  = Time.now
    end

    def call
      Word.create(user: @user, word: 'supply', translation: 'fourniture', last_review: @now)
      Word.create(user: @user, word: 'take over', translation: 'reprendre', last_review: @now)
      Word.create(user: @user, word: 'lukewarm', translation: 'tiède', last_review: @now)
    end
  end
end
