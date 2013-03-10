class UrgencyTypeValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless %w(normal medium high critical).include?(value.downcase)
      object.errors[attribute] << (options[:message] || "is not a proper urgency type.") 
    end
  end
end