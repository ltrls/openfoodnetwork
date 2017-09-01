module OpenFoodNetwork
  module DecimalFilter
    def decimal_filter_for(object, attributes:, actions: [:create, :update])
      before_filter :parse_decimals, only: actions

      self.class_eval do
        define_method(:parse_decimals) do
          logger.debug "========== applying parse_decimals filter"
          logger.debug "Params: #{params}"
          attributes.each do |attribute|
            logger.debug "#{attribute}: #{params[object][attribute]}"
            params[object][attribute] = OpenFoodNetwork::DecimalFilter::Parser.string_to_price params[object][attribute]
            logger.debug "=> #{params[object][attribute]}"
          end
        end
      end
    end

    module Parser
      module_function

      def string_to_price(string)
        return string if string.blank?

        string.gsub!(/[^\d.,]/,'')          # Replace all Currency Symbols, Letters and -- from the string
        if string =~ /^.*[\.,]\d{1}$/       # If string ends in a single digit (e.g. ,2)
          string = string + "0"             # make it ,20 in order for the result to be in "cents"
        end
        unless string =~ /^.*[\.,]\d{2}$/   # If does not end in ,00 / .00 then
          string = string + "00"            # add trailing 00 to turn it into cents
        end
        string.gsub!(/[\.,]/,'')            # Replace all (.) and (,) so the string result becomes in "cents"
        string.to_f / 100                   # Let to_float do the rest
      end
    end
  end
end
