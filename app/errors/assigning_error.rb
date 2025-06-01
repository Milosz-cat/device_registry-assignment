module AssigningError # Created to solve "uninitialized constant AssigningError", based on (https://alessiobussolari.medium.com/mastering-custom-errors-in-rails-b795649a0779) and (https://www.reddit.com/r/rails/comments/n96emv/the_best_place_to_put_custom_error_classes/)
  class AlreadyUsedOnUser < StandardError; end 
  class AlreadyUsedOnOtherUser < StandardError; end
  class AssignmentLimitReached < StandardError; end
end
