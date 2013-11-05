class CreateImmonetMails < ActiveRecord::Migration
  def change
    create_table :immonet_mails do |t|
      t.string :body
      t.string :subject
      t.text :headers
      t.text :raw

      t.timestamps
    end
  end
end
