class Removebookauthor < ActiveRecord::Migration[6.1]
  def change
    remove_reference :authors, :book
  end
end