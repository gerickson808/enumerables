module Enumerable

	def my_each
		return self unless block_given?
		for i in self
			yield(i)
		end
	end


	def my_each_with_index
		return self unless block_given?
		for i in 0...length
			yield(self[i],i)
		end

	end	

	def my_select

		return self unless block_given?
		selected =[]
		self.my_each do |q|
			selected.push(q) if yield(q)
		end
		return selected
	end

	def my_all?
		return true unless block_given?
		selected =[]
		self.my_each do |q|
			selected.push(q) if yield(q)
		end
		if selected == self.to_a then return true else return false end

	end

	def my_any?
		return true unless block_given?
		selected =[]
		self.my_each do |q|
			selected.push(q) if yield(q)
		end
		if selected == [] then return false else return true end
	end

	def my_none?
		return false unless block_given?
		selected =[]
		self.my_each do |q|
			selected.push(q) if yield(q)
		end
		if selected == [] then return true else return false end
	end

	def my_count(obj = nil)
		selected = 0
		return self.length unless (block_given? || obj)
		if obj
			self.my_each do |q| 
				if q == obj
					selected += 1
				end
			end
		else
			self.my_each do |q|
				selected += 1 if yield(q)
			end
		end
		return selected
	end

	def my_map
		return self unless block_given?
		new_self = []
		for i in 0...length
			q = yield(self[i])
			new_self << q
		end
		return new_self
	end	

	def my_map_proc (proc = nil)
		return self unless proc
		new_self = []
		for i in 0...length
			q = proc.call(self[i])
			new_self << q
		end
		if block_given?
			new_self2 = []
			for i in 0...length
				q = yield(new_self[i])
				new_self2 << q
			end
			return new_self2
		end
		return new_self
	end	

	def my_inject(start = nil)
		return self unless block_given?
		#takes Object::self, optional start point,
		#and a block (passed to with yield)
		#and runs block on each item in self
		#starting with start point or first item
		puts "Start is #{start}"
		p self[0]
		if start.is_a? Fixnum
			result = start
			initial = 0
		else
			result = self[0]
			initial = 1
		end
		puts "Result is #{result}"
		self.my_each_with_index do |number,i|
			result = yield(result,number) if i >= initial
		end
		return result
	end


end

def multiply_els(array)

	array.my_inject {|result, number| result * number}

end

array = [3,5,7,9,11]

map_proc = Proc.new {|n| n*2}

p array.my_map {|n| n*2}
p array.my_map_proc(map_proc)

p array.my_map_proc {|n| n*2}
p array.my_map_proc(map_proc){|n| n*2}