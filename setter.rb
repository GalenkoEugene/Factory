		  def []=(atr, val)
		    begin
		      if atr.is_a?(Integer)
		        return self.send("#{@list[atr]}=", val) if @list[atr]
		        raise IndexError, "IndexError: Wrong index of attributes"
		      else
		        return self.send("#{atr}=", val) if self.instance_variables.include? "@#{atr}".to_sym
		        raise NameError, "NameError: No such field"
		      end
		  	rescue  => e
		  	  puts e.message
		    end
		  end