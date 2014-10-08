class Comment < ActiveRecord::Base
  belongs_to :status
  belongs_to :user
  acts_as_votable
  before_destroy :delete_activity

  validates :body, presence: true,
                      length: { minimum: 2 }

  validates :status_id, presence: true

  validates :user_id, presence: true

  def delete_activity
    Activity.find_by(targetable_id: self.class.find(self.id)).destroy!
  end

end