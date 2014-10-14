class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  before_destroy :delete_activity

  accepts_nested_attributes_for :document

  validates :body, presence: true,
                      length: { minimum: 2 }

  validates :user_id, presence: true

  def name_with_initial
    "#{subject}"
  end

  def delete_activity
    Activity.find_by(targetable_id: self.class.find(self.id)).destroy!
  end  

end
