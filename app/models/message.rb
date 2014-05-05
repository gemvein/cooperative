class Message < ActiveRecord::Base
  # attr_accessible :recipient_id, :sender_id, :subject, :body, :parent_id, :recipient_nickname
  validates_presence_of :body, :sender
  validates_presence_of :subject, :if => "parent.nil?"
  validates_presence_of :recipient_nickname
  validate :you_cant_send_messages_to_yourself

  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  belongs_to :parent, :class_name => 'Message'

  has_many :children, :foreign_key => 'parent_id', :class_name => 'Message'

  def self.unread
    where(:read_at => nil)
  end

  def self.threads
    where('id IN (?)', self.all.map(&:thread))
  end

  def self.sent_by(sent_by)
    where(:sender_id => sent_by, :deleted_by_sender => [false, nil, '', 0])
  end

  def self.received_by(received_by)
    where(:recipient_id => received_by, :deleted_by_recipient => [false, nil, '', 0])
  end

  def self.trash_by(trash_by)
    where("(sender_id = ? AND deleted_by_sender = 't') OR (recipient_id = ? AND deleted_by_recipient = 't')", trash_by, trash_by)
  end

  
  def you_cant_send_messages_to_yourself
    if(recipient == sender)
      errors.add(:recipient_nickname, "can't be yourself") #TDDO Internationalize this
    end
  end
  
  def thread
    if self.parent.nil?
      self
    else
      self.parent.thread
    end
  end
  
  def thread_count
    if children
      count = 1
      for child in children
        count += child.thread_count
      end
      count
    else
      1
    end
  end
  
  def recipient_nickname
    if recipient.nil?
      ''
    else
      recipient.nickname
    end
  end

  def recipient_nickname=(value)
    self.recipient = User.find_by_nickname(value)
  end
  
  def mark_as_read_by(user)
    if recipient == user
      read
    end
    unless children.empty?
      for child in children
        child.mark_as_read_by(user)
      end
    end
  end
  
  def read
    if read_at.blank?
      self.read_at = Time.now
      self.save
    end
  end
  
  def unread?(user)
    if read_at.blank? and recipient == user
      return true
    elsif !children.empty?
      for child in children
        if child.unread?(user)
          return true
        end
      end
    else
      return false
    end
    false
  end
  
  def with(user)
    if recipient != user
      recipient
    elsif sender != user
      sender
    else
      raise "Messages cannot be soliloquies!"
    end
  end
  
  def move_to_trash(user)
    if user == sender
      self.deleted_by_sender = true
      self.save
    elsif user == recipient
      self.deleted_by_recipient = true
      self.save
    else
      raise "You have no authority to delete this message"
    end
    for child in children
      child.move_to_trash(user)
    end
  end
  
  def restore(user)
    if user == sender
      self.deleted_by_sender = false
      self.save
    elsif user == recipient
      self.deleted_by_recipient = false
      self.save
    else
      raise "You have no authority to restore this message"
    end
    for child in children
      child.restore(user)
    end
  end
end