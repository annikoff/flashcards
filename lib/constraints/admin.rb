# frozen_string_literal: true
module Constraints
  class Admin
    def self.matches?(request)
      user_id = request.session[:user_id]
      return false if user_id.blank?
      User.find(user_id).is_admin?
    end
  end
end
