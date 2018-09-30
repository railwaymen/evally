class V1::EmployeeSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :first_name, :last_name, :position, :hired_at, :last_evaluation_at, :next_evaluation_at
   
end
