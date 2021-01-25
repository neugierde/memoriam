class SidebarComponent < ViewComponent::Base
  include ViewComponent::SlotableV2

  renders_many :links, LinkComponent
end
