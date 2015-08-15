# == Schema Information
#
# Table name: astro_blogs
#
#  uuid        :string(50)       not null, primary key
#  title       :string(255)
#  description :string(255)
#  url         :string(255)
#  explanation :text(65535)
#  picture_url :string(255)
#  date        :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class AstroBlogSerializer < ActiveModel::Serializer
  attributes :uuid, :title, :url, :picture_url, :date
end
