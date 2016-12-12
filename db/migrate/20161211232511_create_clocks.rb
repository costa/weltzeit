class CreateClocks < ActiveRecord::Migration[5.0]
  def change
    create_table :clocks do |t|
      t.string :time_zone_name

      t.timestamps
    end
  end
end
