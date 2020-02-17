class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    drop_table :contacts do |t|

      t.timestamps
    end
  end
end
