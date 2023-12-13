class RemoveReferencesFromEntries < ActiveRecord::Migration[6.1]
  def change
    remove_column :entries, :references, :string
  end
end
