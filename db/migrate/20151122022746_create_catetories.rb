class CreateCatetories < ActiveRecord::Migration
  def change
    create_table :catetories do |t|
      t.string :name
      t.timestamps
    end
  end
end
