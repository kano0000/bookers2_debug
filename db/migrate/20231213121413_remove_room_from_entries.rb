class RemoveRoomFromEntries < ActiveRecord::Migration[6.1]
  def change
    remove_column :entries, :room, :string
  end
end
