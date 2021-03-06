# coding: utf-8

module Preflight
  module Rules
    # Every PDF has an optional 'Info' dictionary. Check that the dictionary
    # has a 'Trapped' entry that is set to True or False
    #
    # Arguments: none
    #
    # Usage:
    #
    #   class MyPreflight
    #     include Preflight::Profile
    #
    #     rule Preflight::Rules::InfoSpecifiesTrapping
    #   end
    #
    class InfoSpecifiesTrapping

      def check_hash(ohash)
        array = []
        info = ohash.object(ohash.trailer[:Info])
        if info.nil?
          array << Issue.new("Info dict definition is missing", self)
        else
          if !info.has_key?(:Trapped)
            array << Issue.new("Info dict does not specify Trapped", self)
          elsif info[:Trapped] != :True && info[:Trapped] != :False
            array << Issue.new("Trapped value of Info dict must be True or False", self)
          end
        end
        array
      end
    end
  end
end
