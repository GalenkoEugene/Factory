class Factory
	def self.new(*args, &block)
	  Class.new do
	    inst_vars = args
	    @@list = []
	    inst_vars.each { |a| attr_accessor a }
	    define_method :initialize do |*val|
		  inst_vars.each_with_index do |kay, i|
	        instance_variable_set("@#{kay.to_s}", val[i])
	        @@list << val[i]
	      end
	    end

	    def [](atr)
	      begin
	        if atr.is_a?(Integer)
	          return @@list[atr] if @@list[atr]
	          raise IndexError, "IndexError: Wrong index of attributes"
	        else
	          return self.send(atr) if self.instance_variables.include? "@#{atr}".to_sym
	          raise NameError, "NameError: No such field"
	        end
	  	  rescue  => e
	  	  	puts e.message

	    end
	      block.call if block_given?
	    end
	  end
	end

end


 User = Factory.new(:name, :age)
 user = User.new("Alex", 24)

 user[:name]
 user["name"]
 user.name
 user[0]