class CreateUsers < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :author
      t.string :url
      t.references :user
      t.timestamps null: true
    end

    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.timestamps null: true
    end

    create_table :reviews do |t|
      t.references :user
      t.references :song
      t.string :content
      t.integer :rating
      t.timestamps null: true
    end
  end
end
