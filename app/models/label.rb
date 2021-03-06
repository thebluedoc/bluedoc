# frozen_string_literal: true

class Label < ApplicationRecord
  second_level_cache expires_in: 1.week

  belongs_to :target, polymorphic: true

  validates :title, presence: true, uniqueness: {scope: :target}, length: 2..50
  validates :color, presence: true

  validate do
    unless BlueDoc::Utils.valid_color?(color)
      errors.add :color, "Invalid color format"
    end
  end
end
