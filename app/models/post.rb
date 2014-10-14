class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  has_many :activities, :as => :targetable, :dependent => :destroy

  accepts_nested_attributes_for :document

  validates :body, presence: true,
                      length: { minimum: 2 }

  validates :user_id, presence: true

  def name_with_initial
    "#{subject}"
  end

end
