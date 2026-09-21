class User < ApplicationRecord
    before_validation :set_library_card, on: :create

    validates :full_name, presence: true, length: { minimum: 3 }
    validates :library_card, presence: true, uniqueness: true
    validates :email,
              presence: true,
              uniqueness: true,
              format: { with: /\A[^@\s]+@[^@\s]+\z/ }


    private
    def set_library_card
        self.library_card ||= loop do
            possible_library_card = Random.rand(999999)
            break possible_library_card unless self.class.exists?(library_card: possible_library_card)
        end
    end
end
