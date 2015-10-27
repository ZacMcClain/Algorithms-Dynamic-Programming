
#Title: Dynamic Programming
CSCI406 Assignment 2

## Program Information:

* Names: 
	* Brandon Maurice Parrish
	* Christopher Travis Johnson
	* Zac McClain
* Date: 10/27/2015
* Course: CSCI406 Algorithms
* Professor: Dr. Dinesh Mehta

##Source file(s):
	src/main.cpp

##Description:
For each of n days, you’re presented with a quantity of
data (on day i, you’re presented xi terabytes). For each terabyte you process, you receive a
fixed revenue, but any unprocessed data becomes unavailable at the end of the day (i.e., you
can’t work on it in any future day). The amount of data you can process on a given day goes 
down with each day that passes since the most recent reboot of the system. On the first day 
after a reboot, you can process s1 terabytes, on the second day after a reboot you can 
process s2 terabytes, and so on, upto sn; we assume s1 > s2 > s3 > · · · > sn > 0. To get 
the system back to peak performance, you can choose to reboot it; but on any day you choose 
to reboot the system, you can’t process any data at all. Given the amounts of available data 
x1, x2, . . . , xn for the next n days, and given the profile of your system as expressed by 
s1, s2, . . . , sn (and starting with a freshly rebooted system on Day 1), choose the days on 
which you are going to reboot so as to maximize the total amount of data you process.

##Usage:
	~/path/to/main.cpp $ ./dymProg ../inputs/ex1.txt

##Build Instructions:
	~/path/to/workingDir $ make

##Files:
Files must observe the fallowing format: Comments are denoted by a '%' symbol
at the beginning of a line. Full line comments only, Comments are contiguous and only
found at the beginning of the program. The first data line will always contain the
number of data entries in the file. All subsequent lines will be interpreted as data.

##Notes:

###Bugs:
None yet

###Implementation Details:
Please see in the comments in my source code for more details.

