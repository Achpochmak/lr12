# frozen_string_literal: true

class CreatePolyndroms < ActiveRecord::Migration[6.1]
  def change
    create_table :polyndroms do |t|
      t.integer :param
      t.string :index
      t.string :num
      t.string :rev
      t.string :theory

      t.timestamps
    end
  end
end
