module Profiled
  class Area < ApplicationRecord
    include Model::Area
    include Com::Ext::Taxon
  end
end
