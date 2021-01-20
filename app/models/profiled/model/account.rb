module Profiled
  module Model::Account
    extend ActiveSupport::Concern

    included do
      has_many :profiles, foreign_key: :identity, primary_key: :identity
      after_save :sync_to_profiles, if: -> { saved_change_to_identity? || saved_change_to_user_id? || saved_change_to_confirmed? }
    end

    def sync_to_profiles
      if confirmed?
        profiles.update_all(user_id: self.user_id)
      end
    end

  end
end
