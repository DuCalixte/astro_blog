# == Schema Information
#
# Table name: astro_blogs
#
#  uuid        :string(50)       not null, primary key
#  title       :string(255)
#  description :text(65535)
#  url         :string(255)
#  explanation :text(65535)
#  picture_url :string(255)
#  date        :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  astro_blogs_title_with_link  (title,url) UNIQUE
#

require 'rails_helper'

RSpec.describe AstroBlog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
