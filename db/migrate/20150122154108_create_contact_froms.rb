class CreateContactFroms < ActiveRecord::Migration
  def change
    create_table :contact_froms do |t|
      t.string :name
      t.string :email
      t.string :messge
      t.string :message_title

      t.timestamps
    end
  end
end
