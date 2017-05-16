# frozen_string_literal: true

# setter for Factory
def []=(atr, val)
  begin
    if atr.is_a?(Integer)
      return send("#{instance_variables[atr]}=".extension[1..-1], val) if instance_variables[atr]
      raise IndexError, "IndexError: Wrong index of attributes"
    else
      return send("#{atr}=", val) if instance_variables.include? "@#{atr}".to_sym
      raise NameError, "NameError: No such field"
    end
  rescue => e
    puts e.message
  end
end
