class Entry < ApplicationRecord
    belongs_to :user

    validates :date, presence: true, uniqueness: true, on: [:create, :update]
    validates :text, presence: true, on: [:create, :update]
    validates :user, presence: true, on: [:create, :update]
end
