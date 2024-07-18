class CreateGeolocations < ActiveRecord::Migration[7.1]
  def change
    create_table :geolocations do |t|
      t.string :ip_address
      t.string :url
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.string :country_code
      t.string :timezone
      t.string :timezone_code

      t.timestamps
    end
  end
end
