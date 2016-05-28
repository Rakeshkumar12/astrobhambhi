class Service < ActiveRecord::Base
	has_attached_file :image, :styles => { :small => "150x150>" }

validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
