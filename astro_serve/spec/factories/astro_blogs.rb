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

FactoryGirl.define do
  factory :astro_blog do
    uuid ""
title "MyString"
description "MyString"
url "MyString"
explanation "MyText"
picture_url "MyString"
date "2015-08-14 23:35:20"
  end

end
