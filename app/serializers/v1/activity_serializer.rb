class V1::ActivitySerializer
  include FastJsonapi::ObjectSerializer
  
  attribute :title do |activity|
    activity.title
  end

  attribute :description do |activity|
    activity.description
  end

  attribute :created_at do |activity|
    activity.created_at.iso8601
  end
   
end
