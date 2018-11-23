module V1
  class UserSerializer
    include FastJsonapi::ObjectSerializer

    attributes :email, :first_name, :last_name

    attribute :setting do |user|
      user.setting.attributes.slice(
        'default_draft_items',
        'default_upcoming_items',
        'default_next_evaluation_time',
        'public_view_enabled'
      )
    end

  end
end
