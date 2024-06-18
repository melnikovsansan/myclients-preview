class Company < ApplicationRecord

  def self.current
    RequestStore.store[:current_company]
  end

  def current!
    RequestStore.store[:current_company] = self
  end
end
