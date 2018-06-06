class Login < ApplicationRecord

  acts_as_paranoid
  has_secure_password

  has_many :expenses, inverse_of: :login, dependent: :destroy

  def self.ordered
    order(:name)
  end

end
