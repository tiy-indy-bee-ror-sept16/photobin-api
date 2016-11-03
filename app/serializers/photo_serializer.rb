class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :photo, :caption
  has_one :user

  def photo
    Refile.attachment_url(object, :image, :fit, 800, 800, format: "jpg")
  end
end
