# initialize_table will populate a 2D array (table) with an initial row of 0 values
def initialize_table(given,  can)
	table = Array.new(can.length + 1)
    (0...(can.length + 1)).each { |x| table[x] = Array.new(given.length) }
	(0...(given.length)).each { |x| table[0][x] = 0 }
	return table	
end

# output the structure of the table to the console
def print_table table
	table.each do |x|
		if x != nil
			x.each { |y| print "#{y} " }	
		end
		puts
	end
end	

# return limiting factor (amount of data or server processing power)
def min(x, s) 
	if x < s
		return x
	end
 	
	return s
end

# return the maximum value of a specific column in a table
# linear search causes O(n)
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
		
# process the data sets X (given) and S (can)
# two iterative loops causes O(n^2)?
def make_table( given, can )
	table = initialize_table(given, can)	# init row of 0s

	# need one more row than columns (n + 1) rows
	can = [0] + can

	(0...(given.length)).each do |x|
		(1...(can.length + 1)).each do |s|

			# do not calculate min for lower diagonals
			# cannot possibly process x_1 with the power of s_2, nor x_2 with s_3
			if s - x < 2	
				
				if x - 1 < 0 || s - 1 < 0 
					table[s][x] = min( given[x], can[s] )	# table[1][0] is min( x_1, s_1 )
				
				elsif s - x >=  0
					table[s][x] = min( given[x], can[s] ) + table[ s - 1 ][ x - 1 ] 
					# calculate sum of diagonals

				elsif s == 1

					table[s][x] = min( given[x], can[s] ) + table[ s - 1 ][ x - 1 ] + column_max(table, x - s - 1 )
					# calculate sum of diagonals + max of the column immediately left of a reboot

				else 
					table[s][x] = min( given[x], can[s] ) + table[ s - 1 ][ x - 1]
					# what does this do differently from the second condition?

				end
			end 
		end
	end

 	print_table table	# output the table
	return table
end		
					
make_table( [10,1,7,7], [8,4,2,1] )
