module RailsProfile::Pupil
  extend ActiveSupport::Concern

  included do
    has_many :tutelages, foreign_key: :pupil_id, dependent: :delete_all, inverse_of: :pupil
    has_many :tutelars, through: :tutelages
    has_many :client_maintains, class_name: 'Maintain', foreign_key: :client_id, inverse_of: :client
    accepts_nested_attributes_for :tutelages, reject_if: :all_blank
  end


end
