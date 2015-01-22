class ChangeRegistersNameToTitles < ActiveRecord::Migration

  def change
    change_table :registers do |t|
      t.rename :name, :title
      t.change :title, :text
      t.column :subtitle, :text
    end
  end

end
