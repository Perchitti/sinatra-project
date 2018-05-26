class User < ActiveRecord::Base

  has_many :sentences

  has_secure_password

  def slug
    username.downcase.strip.gsub(" ","-").gsub(/[^\w-]/, "")
  end

  def self.find_by(slug)
    self.all.find{|user| user.slug == slug}
  end

end
