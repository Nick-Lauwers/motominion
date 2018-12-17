# complete

class Conversation < ActiveRecord::Base
  
  belongs_to :sender,    class_name: 'User' 
  belongs_to :recipient, class_name: 'User'
  
  # belongs_to :sender,    class_name: 'User', foreign_key: :sender_id  
  # belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  
  has_many :messages, dependent: :destroy

  has_many :appointments, dependent: :destroy
  has_many :vehicles, through: :appointments
  
  accepts_nested_attributes_for :appointments, allow_destroy: true
  
  has_many :vehicle_inquiries, dependent: :destroy
  has_many :vehicles, through: :vehicle_inquiries
  
  accepts_nested_attributes_for :vehicle_inquiries, allow_destroy: true
  
  # has_many :vehicles, through: :inquiries

  # Experiment
  # has_one :vehicle, dependent: :destroy
  
  # validates_uniqueness_of :sender, scope: :recipient
  
  # scope :involving, -> (user) do
  #   where("conversations.sender = ? OR conversations.recipient = ?", user, user)
  # end
  
  # scope :between, -> (sender, recipient) do
  #   where("(conversations.sender = ? AND conversations.recipient = ?) OR 
  #         (conversations.sender = ? AND conversations.recipient = ?)",
  #         sender, recipient, recipient, sender)
  # end
  
  # validates :sender_id, :recipient_id, :sender_archived, :recipient_archived, 
  #           presence: true
  
  validates_uniqueness_of :sender_id, scope: :recipient_id
  
  scope :involving, -> (user) do
    where("conversations.sender_id = ? OR conversations.recipient_id = ?", user.id, user.id)
  end
  
  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR 
          (conversations.sender_id = ? AND conversations.recipient_id = ?)",
          sender_id, recipient_id, recipient_id, sender_id)
  end
end