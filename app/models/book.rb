class Book < ApplicationRecord
    before_validation :set_serial_number, on: :create
    validates :serial_number, presence: true, uniqueness: true
    validates :title, presence: true

    belongs_to :author
    has_many :user_books, -> { where(return_time: nil) }
    has_many :users, through: :user_books
    has_many :all_user_books, class_name: "UserBook"
    has_many :all_users, through: :all_user_books, source: :project

    def author_name
        book.author.full_name
    end


    def user
        users&.first&.full_name
    end

    def is_borrowed?
        users.any?
    end

    private
    def set_serial_number
        self.serial_number ||= loop do
            possible_serial_no = Random.rand(999999)
            break possible_serial_no unless self.class.exists?(serial_number: possible_serial_no)
        end
    end
end
