class AddRetryCountToImmonetLinks < ActiveRecord::Migration
  def change
    add_column :immonet_links, :retry_count, :integer
  end
end
