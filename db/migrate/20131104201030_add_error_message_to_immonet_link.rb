class AddErrorMessageToImmonetLink < ActiveRecord::Migration
  def change
    add_column :immonet_links, :error_message, :text
  end
end
