class Work < ApplicationRecord
  has_attached_file :image, styles: { medium: "200x200#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  has_many :comments, as: :commentable
  belongs_to :stylist
  belongs_to :user, optional: true
end
