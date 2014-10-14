class User < ActiveRecord::Base
  acts_as_messageable
  acts_as_voter
  before_save { self.email   = email.downcase }
  before_save { self.user_id = self.id }
  before_create :strip_whitespace
  before_create :create_remember_token 
  validates :first_name, presence: true, length: { maximum: 17 }
  validates :last_name, presence: true, length: { maximum: 17 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  validates :user_name, presence: true, 
            length: { minimum: 3, maximum: 17 },
            uniqueness: { case_sensitive: false }

  has_many :statuses
  has_many :questions
  has_many :comments
  has_many :answers
  has_many :lessons
  has_many :activities, :dependent => :destroy
  has_many :albums
  has_many :pictures
  has_many :documents
  has_many :jobs
  has_many :posts
  has_many :taggings
  has_many :tags, through: :taggings
  has_secure_password
  paginates_per 20
  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  has_many :user_friendships
  has_many :friends, -> { where user_friendships: { state: 'accepted'} }, through: :user_friendships

  has_many :pending_user_friendships, -> { where state: 'pending' },
                                      class_name: 'UserFriendship', 
                                      foreign_key: :user_id
  has_many :pending_friends, through: :pending_user_friendships, source: :friend

  has_many :requested_user_friendships, -> { where state: 'requested' },
                                      class_name: 'UserFriendship',
                                      foreign_key: :user_id
  has_many :requested_friends, through: :requested_user_friendships, source: :friend

  has_many :blocked_user_friendships, -> { where state: 'blocked' },
                                      class_name: 'UserFriendship',
                                      foreign_key: :user_id
  has_many :blocked_friends, through: :blocked_user_friendships, source: :friend

  has_many :accepted_user_friendships, -> { where state: 'accepted' },
                                      class_name: 'UserFriendship',
                                      foreign_key: :user_id
  has_many :accepted_friends, through: :accepted_user_friendships, source: :friend
  
  def self.get_gravatars
    all.each do |user|
      if user
        user.avatar = URI.parse(user.gravatar_url)
        user.save
        print "."
      end
    end
  end

  def name_with_initial
    "#{full_name}"
  end

  def self.online_now
    User.where("updated_at > ?", 5.minutes.ago).each
  end

  def self.online_idle
    User.where("updated_at > ?", 20.minutes.ago).each
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def mailboxer_email(object)
    email
  end

  def full_name
    first_name + "\s" + last_name
  end

  def has_blocked?(other_user)
    blocked_friends.include?(other_user)
  end

  # def delete_activity
    # Activity.find_by(user_id: self.id).destroy!
  # end 

  def create_activity(item, action)
    activity            = activities.new
    activity.targetable = item
    activity.action     = action
    activity.save
    activity
  end

  private

  def strip_whitespace
    self.first_name = self.first_name.strip
    self.last_name  = self.last_name.strip
    self.email      = self.email.strip
    self.user_name  = self.user_name.strip
    self.github     = self.github.strip
    self.linkedin   = self.linkedin.strip
    self.facebook   = self.facebook.strip
  end

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end