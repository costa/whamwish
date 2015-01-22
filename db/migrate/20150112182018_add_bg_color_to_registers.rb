class AddBgColorToRegisters < ActiveRecord::Migration
  def change
    add_column :registers, :bg_color, :string
  end
end
