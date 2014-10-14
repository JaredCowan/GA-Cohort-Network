class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  has_many :answers
  has_many :taggings
  has_many :tags, through: :taggings
  before_destroy :delete_activity
  acts_as_votable

  paginates_per 10

  accepts_nested_attributes_for :document

  validates :subject, presence: true,
                      length: { minimum: 2 }

  validates :body, presence: true,
                      length: { minimum: 2 }

  validates :user_id, presence: true

  def delete_activity
    Activity.find_by(targetable_id: self.class.find(self.id)).destroy!
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).questions
  end

  def self.tag_counts
    Tag.select("tags.id, tags.name,count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id, tags.id, tags.name")
  end   

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end