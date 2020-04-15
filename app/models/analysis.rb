class Analysis < ApplicationRecord
  belongs_to :entry

  validates :raw_results, presence: true, on: [:create, :update]
  validates :entry, presence: true, on: [:create, :update]
end
