// System
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <sstream>
#include <string>
#include <cmath>

// Use colored text outputs
static const bool COLOR_ON = true;
int* sArray;
int** dataSums;

using namespace std;

// Text outputs
void outputColoredText( string message, int color, bool newLine )
{
	if( COLOR_ON ) {
		if( newLine ) {
			cout << "\x1b[3" << color << ";1m" << message << "\x1b[0m" << endl;
		} else {
			cout << "\x1b[3" << color << ";1m" << message << "\x1b[0m";
		}
	} else {
		if( newLine ) {
			cout <<  message << endl;
		} else {
			cout << message;
		}
	}
}

// Takes a message then two colors both [0,7] the first is the text color the next
// is the background color fallowed by a boolean, true if a new line is needed.
void outputColoredTandB( string message, int textColor, int bgColor, bool newLine )
{
	if( COLOR_ON ) {
		if( newLine ) {
			cout << "\x1b[3" << textColor << ";4" << bgColor << ";1m " 
				<< message << " \x1b[0m" << endl;
		} else {
			cout << "\x1b[3" << textColor << ";4" << bgColor << ";1m "
				<< message << " \x1b[0m";
		}
	} else {
		if( newLine ) {
			cout <<  message << endl;
		} else {
			cout << message;
		}
	}
}

void outputMessage( string message, char* info_var = NULL )
{
	if( info_var == NULL ) {
		outputColoredText( message, 2, true );
	} else { 
		outputColoredText( message, 2, false );
		outputColoredTandB( info_var, 7, 0, true );
	}
}

void outputWarning( string err_message, char* err_var = NULL )
{
	if( err_var == NULL ) {
		outputColoredText( err_message, 1, true );
	} else {
		outputColoredText( err_message, 1, false );
		outputColoredTandB( err_var, 7, 0, true );
	}
}

template <typename T> string numberToString( T Number )
{
    ostringstream ss;
    ss << Number;
    return( ss.str() );
}

void printArray( int* stringAddr, int arrayLen, string name ) 
{
  cout << name << ": [";
  for( int i = 0; i < arrayLen; i++ ) {
    if( i == (arrayLen-1) ) {
      cout << stringAddr[i];
    } else {
      cout << stringAddr[i] << ", ";
    } 
  }
  cout << "]" << endl;
}

int calcSumNoReboot( int* sArray, int* xArray, int days )
{
	int dataSum = 0;
	for( int i = 0; i < days; i++ )  {
		// if si < xi we can only process si terabytes of data
		if( sArray[i] < xArray[i] )  {
			dataSum += sArray[i];
		// if si > xi we can process all xi terabytes of data
		}else if( sArray[i] > xArray[i] )  {
			dataSum += xArray[i];
		} else { // si == xi we can process all xi terabytes of data
			dataSum += xArray[i];
		}	
	}
	return( dataSum );
}

int dynamicProgramingAlgorithm( int* xArray, int xSize ) 
{
	
}

void input() {
	FILE *filePointer;
  	char line[1024];
  	char* fileName = argv[1];
  	int numberOfDays; // aka n
  	int* xArray; // x0...xn

  	// ensure that only one argument has been provided
  	if( argc != 2 ) {
		outputWarning( "Unsupported number of arguments where provided!" );
		outputMessage( "Usage example: ", (char*)"workingDir/ $ ./dynProg ex1.txt" );
		outputMessage( "All files must be in the correct format." );
		exit( 1 );
	}

  	// Check that the provided argument is a file that can be opened.
	if( (filePointer = fopen(fileName, "r") ) == NULL) {
		outputWarning( "Could not open file: ", fileName );
		exit( 1 );
	}
	outputMessage( "Reading in data from file: ", fileName );

	// ignore comments.
	fgets( line, 128, filePointer );
	while (line[0] == '%') {
		fgets( line, 128, filePointer ); 
	}

	// Read number of rows (rowCount), number of columns (columnCount) and
	sscanf( line, "%d\n", &numberOfDays );

	// Allocate memory;
	sArray = new int[numberOfDays];
	xArray = new int[numberOfDays];
	dataSums = new int[numberOfDays][numberOfDays];

	// readIn the rest of the array
	for( int i = 0; i < numberOfDays; i++ ) {
		fscanf( filePointer, "%d %d\n", &(sArray[i]), &(xArray[i]) );
	}

	// Close the file.
	fclose( filePointer );

}

int main( int argc, char** argv )
{
	// Output Arrays to insure correctness of loading:
	cout << "N: " << numberOfDays << endl;
	if( numberOfDays < 40 ) {
		printArray( sArray, numberOfDays, "S" );
		printArray( xArray, numberOfDays, "X" );
	}

	// Save the result of our dynamic programing algorithm.
	int maxDataProcessed = dynamicProgramingAlgorithm( xArray, numberOfDays );

	cout << "Data processed with reboots: ";
	cout << numberToString(maxDataProcessed) << endl;

	// Calculate the amount of data processed with no reboot.
	int maxDataProcessedWithNoReboot = calcSumNoReboot( sArray, xArray, numberOfDays );

	cout << "Data processed with no reboots: ";
	cout << numberToString(maxDataProcessedWithNoReboot) << endl;

	// Deallocate memory
	delete[] sArray;
	sArray = NULL;
	delete[] xArray;
	xArray = NULL;		

	// exit with success code 0
	return( 0 );
}
