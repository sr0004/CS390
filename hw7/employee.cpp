
#include <stdio.h>
#include "employee.h"
#include <fstream>
#include <iostream>
#include <string>
using namespace std;


void EmployeeSearch(const char* file){
  employee emp; //Employee Structure
  string line; //line
  ifstream in; //file stream
  int matchFound=0;
  string sub;
 
  string answer = "yes"; //answer string for loop comparisons

  while((answer != "Q") && (answer != "q")){//Begin while loop to determine when to quit.
  cout<<"Please enter the first name of the employee you would like to search for."<<endl;
  cin>> emp.firstname;
  cout<<"Please enter the last name of the employee."<<endl;
  cin>>emp.lastname;//cin/cout strings to get names from user.
  matchFound=0;
  in.open(file);
  if(!in.is_open())//Check if file open
    {
      cout<<"File not found\n";//Report file not found if it's not open.
      answer="q";
    }
  
  if(in.is_open())//Check if file open
    {
      while(getline(in, line))//While not at end of file getline
	{
	  if((line.find(emp.firstname) != string::npos) && (line.find(emp.lastname) != string::npos)){
	    //Check input against names in employee struct
	    matchFound=1;
	    cout<<"Firstname/Lastname/Salary\n"<<line<<endl;//Print line matching employee names
	    
	      }
	   
	 
	}
      in.close();//close file when finished

     
    }

  if(matchFound == 0){
    cout<<"No one matching that name was found.\n";//If no match found report it
      }

  matchFound=0;//reset match found
  cout<<"Do you want to search for another employee? Enter yes or type Q/q to quit."<<endl;
  line="clear";
  cin>>answer;
  in.clear();//clear stream to remove trailing \n
  }
}
