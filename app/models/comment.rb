class Comment < ApplicationRecord
  has_many   :comments,    as: :commentable
  belongs_to :commentable, polymorphic: true
  belongs_to :works,       optional:    true
  belongs_to :stylist,     optional:    true
  belongs_to :user
end
