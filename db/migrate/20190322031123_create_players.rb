class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :username
      t.datetime :time_completed
      t.integer :time_taken

      t.timestamps
    end
  end
end
