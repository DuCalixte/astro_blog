require 'uuid_helper'
require_relative 'concerns/cachable.rb'
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

class AstroBlog < ActiveRecord::Base
	self.primary_key = 'uuid'

	include UUIDHelper
	include Cacheable

	# validations
	validates :uuid, presence: true

  	# callbacks
  	before_validation :set_uuid, on: :create


  	# override to_param so find() method can accept :uuid
  	def to_param
  		uuid
  	end
end
