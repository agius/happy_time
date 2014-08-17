class TestModel
  include ActiveModel::Validations

  def initialize(attributes = {})
    @attributes = attributes
  end

  def event_at
    @attributes[:event_at]
  end

  def event_at=(time)
    @attributes[:event_at] = time
  end
  
  def read_attribute_for_validation(key)
    @attributes[key]
  end

  def all_errors
    errors.full_messages.join(', ')
  end
end