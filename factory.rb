# frozen_string_literal: true

# simplified version of Struct
class Factory
  def self.new(*inst_vars, &block)
    Class.new do
      inst_vars.each do |arg|
        raise NameError, "identifier #{arg} needs to be constant" unless arg.is_a? Symbol
        attr_accessor arg
      end

      define_method :initialize do |*val|
        raise ArgumentError if inst_vars.size < val.size
        inst_vars.each_with_index do |key, i|
          instance_variable_set("@#{key}", val[i])
        end
      end

      def [](atr)
        begin
          if atr.is_a?(Integer)
            return instance_variable_get(instance_variables[atr]) if instance_variables[atr]
            raise IndexError, 'IndexError: Wrong index of attributes'
          else
            return send(atr) if instance_variables.include? "@#{atr}".to_sym
            raise NameError, 'NameError: No such field'
          end
        rescue => e
          puts e.message
        end
      end
      class_eval &block if block_given? # block.call if block_given?
    end
  end
end
