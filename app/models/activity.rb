class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :targetable, polymorphic: true

  # paginates_per 10
 
  # ================
  # Not in use. Pending Delete
  # ================
  # def as_json(options={})
    # super(
    #   only: [:action, :id, :targetable_id, :targetable_type, :created_at, :id],
    #   include: :targetable,
    #   methods: [:user_name, :profile_name],
    #   include: :user
    # ).merge(options)
  # end
  # ================
end
