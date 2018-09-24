class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable

end
