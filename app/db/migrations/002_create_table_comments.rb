class CreateTableSurnames < Sequel::Migration
  def up
    create_table :comments do
      primary_key :id
      column :author, :text
      String :text, text: true
      Integer :surname_id
      index :text
    end
  end

  def down
    drop_table :comments
  end
end
