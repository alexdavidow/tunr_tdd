class CreateAlbumsUsers < ActiveRecord::Migration
  def change
    # this table created by a HABTM should not have t.timestamps, only the id fields.
    create_table :albums_users, id: false do |t|
      t.integer :album_id
      t.integer :user_id
    end
  end
end
