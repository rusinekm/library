class Author < ApplicationRecord
    validates :full_name, presence: true, length: { minimum: 3 }
end
