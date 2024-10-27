class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.human_attribute_value(enum_name, enum_value)
    I18n.t("active_record.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value.to_sym}",
            default: enum_value)
  end
end
