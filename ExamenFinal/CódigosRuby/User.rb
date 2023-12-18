class User < ActiveRecord::Base
    validates :username, :presence => true
    validate :username_format
end