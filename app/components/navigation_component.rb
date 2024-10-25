class NavigationComponent < ViewComponent::Base
  def initialize(current_user: nil)
    @current_user = current_user
  end
end
