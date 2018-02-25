class CreateTableSurnames < Sequel::Migration
  def up
    create_table :surnames do
      primary_key :id
      column :title, :text
      String :content, text: true
      index :title
    end
  end

  def down
    drop_table :surnames
  end
end
