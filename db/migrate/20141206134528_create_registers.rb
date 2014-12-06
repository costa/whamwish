class CreateRegisters < ActiveRecord::Migration

  def change
    create_table :registers, :id => false do |t|
      t.string :key, :null => false
      t.string :name

      t.timestamps
    end

    add_index :registers, :key, :unique => true
  end

end
