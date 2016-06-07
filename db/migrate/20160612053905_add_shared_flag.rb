Sequel.migration do
  change do
    alter_table :expenses do
      add_column :shared, :boolean, default: true, null: false
    end
  end
end
