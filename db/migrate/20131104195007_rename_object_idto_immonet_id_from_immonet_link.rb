class RenameObjectIdtoImmonetIdFromImmonetLink < ActiveRecord::Migration
  def change
    change_table :immonet_links do |t|
      t.rename :object_id, :immonet_id
    end
  end
end
