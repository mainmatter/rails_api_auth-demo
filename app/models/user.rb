class User < ActiveRecord::Base

  attr_accessor :email
  attr_accessor :password

  has_one :login

end
