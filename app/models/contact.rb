class Contact
    include ActiveModel::Model
   
    attr_accessor :name, :email, :message
   
    validates :name, presence: true
    validates :email, presence: true , length: {maximum:255},
                format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i} 
    validates :message, presence: true
end