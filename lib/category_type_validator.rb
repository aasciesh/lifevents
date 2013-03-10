class CategoryTypeValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless ['general information', 'alert', 'music', 'entertainment','sports', 'politics','life events', 'community events', 'politics'].include?(value.downcase)
      object.errors[attribute] << (options[:message] || "is not a proper category type.") 
    end
  end
end