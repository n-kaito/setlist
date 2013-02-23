class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :name
      t.integer  :place_id
      t.datetime :open_at

      t.timestamps
    end
  end
end
