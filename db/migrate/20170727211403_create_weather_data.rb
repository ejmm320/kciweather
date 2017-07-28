class CreateWeatherData < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_data do |t|
      t.jsonb :payload, null: false, default: {}
      t.timestamps
    end
    add_index :weather_data, :payload, using: :gin
  end
end
