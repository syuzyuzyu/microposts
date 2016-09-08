class AddProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile, :string
    add_column :users, :place, :string
  end
end
