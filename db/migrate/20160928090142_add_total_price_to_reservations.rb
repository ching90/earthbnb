class AddTotalPriceToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :totalprice, :integer
  end
end
