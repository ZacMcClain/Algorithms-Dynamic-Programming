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
			rowLen = x.size
			x.each_with_index { |y, i|
				if( i == (rowLen - 1) )
					str = "|%5d|" % y
					print str
				elsif( y == nil )
					print "|*****"
				else
					str = "|%5d" % y
					print str
				end
			}
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

	return table
end		

# Given a table and a column find the max in that column and
# return the index of that value.
def column_max_index( table, column )
	max = -9999999
	index = 0
	(0...(column + 2)).each do |x|
		if table[x][column] != nil
			if  table[x][column] > max
				max = table[x][column]
				index = x
			end
		end
	end

	return index
end

# Geven a table find the days on which to reboot, such that
# the the maximum amount of data is processed.
# Return this in an array of days to reboot on.
def trace_back(table)
	
	reboots = Array.new()

	column = table.length - 2
	column = column - column_max_index(table, column) - 1

	while column >= -1
		reboots << (column + 1)

		if column == -1
			break
		end

		column = column - column_max_index(table, column) - 1

	end

	return reboots
end

# The example provided to us in the problem description
exampleX = [10,1,7,7]
exampleS = [8,4,2,1]

# Our test case.
ourX = [10, 3, 1, 8, 6]
ourS = [6, 4, 3, 2, 1]

####### MAIN ########

# Make the table
table = make_table( ourX, ourS )
# output the table
print_table table
# output DP result
puts "Max amount of data that could be processed: #{column_max( table, table.length - 2 )}"
# output traceback
print "To get this max reboot on day(s): "
days = trace_back(table)
dayCount = days.size
days.each_with_index { |day, i|
	if( i == dayCount - 1 )
		print  "#{day+1}\n"
	else
		print  "#{day+1},"
	end

}


