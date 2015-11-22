class DeleteCatetories < ActiveRecord::Migration
  def change
    drop_table :catetories
  end
end
