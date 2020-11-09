class CreateEventDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :event_details do |t|
      t.string :url
      t.string :event_title
      t.string :event_date
      t.string :event_deadline
      t.integer :group_id

      t.timestamps
    end
  end
end
