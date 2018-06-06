class CreateLogins < ActiveRecord::Migration[5.1]

  def change
    create_table :logins do |t|
      t.citext :name,                   null: false
      t.text :password_digest,          null: false
      t.timestamp   :created_at,        null: false
      t.timestamp   :deleted_at
    end
    add_index :logins, [:name], unique: true, where: 'deleted_at IS NULL'
  end

end
