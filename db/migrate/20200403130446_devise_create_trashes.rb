# frozen_string_literal: true

class DeviseCreateTrashes < ActiveRecord::Migration[5.2]
  def change
    # TrashではなくUserにdeviseを追加するため。
    ## Database authenticatable(emailはそもそも追加されている)
    add_column :users, :encrypted_password, :string, null: false, default: ""
    ## Recoverable
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    ## Rememberable
    add_column :users, :remember_created_at, :datetime
    ## Confirmable
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true



    #create_table :trashes do |t|
      ## Database authenticatable
      #t.string :email,              null: false, default: ""
      #t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      #t.string   :reset_password_token
      #t.datetime :reset_password_sent_at

      ## Rememberable
      #t.datetime :remember_created_at

      ### Trackable
      ## t.integer  :sign_in_count, default: 0, null: false
      ## t.datetime :current_sign_in_at
      ## t.datetime :last_sign_in_at
      ## t.string   :current_sign_in_ip
      ## t.string   :last_sign_in_ip

      ## Confirmable
      #t.string   :confirmation_token
      #t.datetime :confirmed_at
      #t.datetime :confirmation_sent_at
      #t.string   :unconfirmed_email # Only if using reconfirmable

      ### Lockable
      ## t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      ## t.string   :unlock_token # Only if unlock strategy is :email or :both
      ## t.datetime :locked_at


      #t.timestamps null: false
    #end

    #add_index :trashes, :email,                unique: true
    #add_index :trashes, :reset_password_token, unique: true
    ## add_index :trashes, :confirmation_token,   unique: true
    ### add_index :trashes, :unlock_token,         unique: true
  end
end
