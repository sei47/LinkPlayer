class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # def self.push_message
  #   if user_signed_in?
  #     messages = Message.where(destination: current_user.id).order(created_at: "DESC")
  #     if current_user.message_read.message_read_last < messages[0]
  #       current_user.message_read.message_read_last = messages[0]
  #       return true
  #     end
  #   end
  # end
end
