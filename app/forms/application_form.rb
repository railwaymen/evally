class ApplicationForm
  include ActiveModel::Model

  attr_reader :model

  def initialize(model, parameters = {})
    @model = model
    super(customized_attributes(parameters))
  end

  def attributes=(attrs)
    super(customized_attributes(attrs))
  end

  def submit!
    return false if invalid?
    @model.update!(instance_values.slice(*fields_list))
  end

  private

  def customized_attributes(attrs)
    model.attributes.merge(attrs.as_json).slice(*fields_list)
  end

  def fields_list
    self.class::FIELDS
  end
end
