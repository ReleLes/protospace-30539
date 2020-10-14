class AddUserIdToPrototypes < ActiveRecord::Migration[6.0]
  # rails g migration AddUserIdToPrototypes user_id:integer でprototypesとusersのidを紐づける
  def change
    add_column :prototypes, :user_id, :integer
  end
end
