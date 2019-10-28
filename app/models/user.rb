class User < ApplicationRecord
  has_many :images, dependent: :destroy

  before_create :generate_key

  private

  def generate_key
    self.key = SecureRandom.hex
  end
end
