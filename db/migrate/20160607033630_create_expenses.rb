class CreateExpenses < ActiveRecord::Migration[5.1]

  def change
    create_table :expenses do |t|
      t.decimal     :amount,            null: false
      t.references  :login              null: false
      t.text        :description,       null: false
      t.boolean     :shared,            null: false, default: true
      t.date        :event_date,        null: false
      t.timestamp   :created_at,        null: false
      t.timestamp   :deleted_at

      #foreign_key [:login_id], :logins, on_delete: :cascade, on_update: :cascade
    end
    add_index :expenses, [:event_date, :login_id]
  end

end
