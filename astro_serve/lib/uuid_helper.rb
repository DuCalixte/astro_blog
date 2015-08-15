# module to aid with UUID work
module UUIDHelper
  # set the uuid in the current object
  def set_uuid
    self.uuid = SecureRandom.uuid if self.uuid.blank?
  end
end
