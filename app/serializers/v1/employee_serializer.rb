class V1::EmployeeSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :first_name, :last_name, :position, :hired_at, :public_token, :next_evaluation_at
   
end
