class AddCompraToCalificacions < ActiveRecord::Migration[5.0]
  def change
    add_reference :calificacions, :compra, foreign_key: true
  end
end
