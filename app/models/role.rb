# == Schema Information
#
# Table name: roles
#
#  created_at    :datetime         not null
#  id            :integer          not null, primary key
#  name          :string
#  resource_id   :integer
#  resource_type :string
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_roles_on_name                                    (name)
#  index_roles_on_name_and_resource_type_and_resource_id
#    (name,resource_type,resource_id)
#  index_roles_on_resource_type_and_resource_id
#    (resource_type,resource_id)
#

# Role
class Role < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_roles

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify
end
