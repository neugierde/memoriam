class SidebarComponent::LinkComponent < ViewComponent::Base
  def initialize(to:, icon: nil, text: nil)
    @to = to
    @icon = icon
    @text = text
    super
  end
end
