class CreateImmonetLinks < ActiveRecord::Migration
  def change
    create_table :immonet_links do |t|
      t.references :immonet_mail, index: true
      t.integer :object_id
      t.text :link
      t.string :status

      t.timestamps
    end
  end
end
