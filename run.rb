	class Factory
	  def self.new(*inst_vars, &block)
		Class.new do
		  inst_vars.each { |a| attr_accessor a }
		  
		  define_method :initialize do |*val|
		  	instance_variable_set(:@list, inst_vars)
			inst_vars.each_with_index do |kay, i|
		      instance_variable_set("@#{kay.to_s}", val[i])
		    end
		  end

		  def [](atr)
		    begin
		      if atr.is_a?(Integer)
		        return self.send(@list[atr]) if @list[atr]
		        raise IndexError, "IndexError: Wrong index of attributes"
		      else
		        return self.send(atr) if self.instance_variables.include? "@#{atr}".to_sym
		        raise NameError, "NameError: No such field"
		      end
		  	rescue  => e
		  	  puts e.message
		    end
		  end
		  class_eval &block if block_given? #block.call if block_given?
		end
	  end
	end

	#for testing
	 User = Factory.new(:name, :age)
	 user = User.new("Alex", 24)

	 user[:name]
	 user["name"]
	 user.name
	 user[0]
	 user[1]
	 user[2]	# raise error "IndexError: Wrong index of attributes"

	 Reader = Factory.new(:name, :email, :city) do
	   def info
	 	 puts "Name is: #{name}, contact me: #{email}, I live in #{city}"
	   end
	 end

	 reader = Reader.new("Oleg", "oleg@gmail.ru", "Dnipro")
	 reader[2]
	 reader.info