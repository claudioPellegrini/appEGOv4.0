class RemoveCompraFromCalificacions < ActiveRecord::Migration[5.0]
  def change
    remove_column :calificacions, :compra_id, :integer
  end
end
