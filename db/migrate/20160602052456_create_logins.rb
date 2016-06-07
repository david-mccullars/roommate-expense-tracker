Sequel.migration do 
  change do
    create_table :logins do
      primary_key :id
      citext :name,                   null: false
      text :password_digest,          null: false
      timestamp   :created_at,        null: false, default: Sequel.function(:now)
      timestamp   :deleted_at

      index [:name], unique: true, where: 'deleted_at IS NULL'
    end
  end
end
