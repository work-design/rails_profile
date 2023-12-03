# frozen_string_literal: true

module Profiled
  module Ext::Member
    extend ActiveSupport::Concern

    included do
      has_many :addresses, class_name: 'Profiled::Address', foreign_key: :member_id
    end

  end
end

