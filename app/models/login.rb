class Login < Sequel::Model

  plugin :paranoid, enable_default_scope: true
  plugin :secure_password

  one_to_many :expenses, reciprocal: :login, dependent: :destroy

  def self.ordered
    order(:name)
  end

end
