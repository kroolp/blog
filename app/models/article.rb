class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }

  has_many :comments, dependent: :destroy
  belongs_to :user

  def tags=(text)
    text.is_a?(String) ? super(sanitize_tags(text)) : super(text)
  end

  private

  def sanitize_tags(text)
    text.split.map(&:downcase).uniq
  end
end
