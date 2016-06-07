Sequel.migration do
  change do
    create_table :expenses do
      primary_key :id
      decimal     :amount,            null: false
      int         :login_id,          null: false
      text        :description,       null: false
      date        :event_date,        null: false
      timestamp   :created_at,        null: false, default: Sequel.function(:now)
      timestamp   :deleted_at

      foreign_key [:login_id], :logins, on_delete: :cascade, on_update: :cascade
      index [:event_date, :login_id]
    end
  end
end
