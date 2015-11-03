def initialize_table(given,  can)
	table = Array.new(can.length + 1)
    (0...(can.length + 1)).each { |x| table[x] = Array.new(given.length) }
	(0...(given.length)).each { |x| table[0][x] = 0 }
	return table	
end

def print_table table
	table.each do |x|
		if x != nil
			x.each { |y| print "#{y} " }	
		end
		puts
	end
end	

def min(x, y) 
	if x < y
		return x
	end
 	
	return y
end

def column_max( table, column )
	
	max = -9999999
	(0...(column + 2)).each do |x|
		if table[x][column] != nil
			if  table[x][column] > max
				max = table[x][column]
			end
		end
	end

	return max
end
		

def make_table( given, can )
	table = initialize_table(given, can)
	
	can = [0] + can

	(0...(given.length)).each do |x|
		(1...(can.length + 1)).each do |y|

			if y - x < 2
				
				if x - 1 < 0 || y - 1 < 0 
					table[y][x] = min( given[x], can[y] )
				
				elsif y - x >=  0
						
					table[y][x] = min( given[x], can[y] ) + table[ y - 1 ][ x - 1 ] 
				elsif y == 1

					table[y][x] = min( given[x], can[y] ) + table[ y - 1 ][ x - 1 ] + column_max(table, x - y - 1 )

				else 
					table[y][x] = min( given[x], can[y] ) + table[ y - 1 ][ x - 1]
				end

						
				
			end 
					
		end

	end

 	print_table table
	return table
end		
					
make_table( [10,1,7,7], [8,4,2,1] )
