class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|
      t.string :message, :default => "Thank you for being!"
      t.integer :user_id
      t.integer :endorser_id

      t.timestamps
    end
  end
end
