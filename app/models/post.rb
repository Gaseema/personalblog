class Post < ActiveRecord::Base
  has_many  :taggings
  has_many :tags, through: :taggings
  belongs_to :admin
  has_attached_file :image, styles: { medium: "400x400>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/ #makes sure an image is uploaded

  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
