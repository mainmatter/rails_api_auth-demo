class User < ActiveRecord::Base

  attr_accessor :identification
  attr_accessor :password

  has_one :login

end
