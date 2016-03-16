#!/bin/bash
#Author: Steven Anderson
#Class CS390 HW5
alter=0      ####  declare alter for later  ######
if [ ! -e report.txt ]; then
    touch report.txt
    echo "     Student Grade Report" >> report.txt
    echo "**********************************" >> report.txt
    echo "Name/Quiz/Homework/Midterm/Final/score/grade" >> report.txt
fi

if [ $# -ne  2 ]; then
    echo "Usage " $0 "Command1 Command2"  ### Check for 2 arguments ####
    exit 1
fi

if [ $1 != 'grade.awk' ]; then 
    echo 'Need grade.awk for arg 1.'      ####check if first arg is correct#####
    exit 1
else 
    echo "Arg 1 is correct."
fi

if [ $2 != 'report.txt' ]; then
    echo 'Need report.txt for arg 2.'    #####Check if second arg is correct######
    exit
else
    echo "arg 2 is correct."
fi


##Begin if everything was correct##
cat report.txt
#Grade selection

echo "Would you like to enter a student record?"
read answer

case $answer in
    Yes|yes) echo -n "Please enter student's name:"    #Check if user wants to enter a record
	;; 
    No|no) cat report.txt; echo "Exiting."
	exit 1
	;;
    *) echo -n "Invalid answer, exiting"
	exit 1
	;;

esac

######ask for name/ check if already in list#############
read name
grep -q "$name" report.txt
if [ $? -eq 0 ]; then
    echo "Student already exists, would you like to modify? Yes/No"
    read mod
    case $mod in
	Yes|yes) alter=1
	    ;;
	No|no) echo "Exiting."
	    exit 1
	    ;;
	*) echo "Invalid option."
	    exit 1
	    ;;
esac
fi

gradeline="$name"
#Name found/ Enter new grades into record.

if [ $alter -eq "1" ];then
    grep "$name" report.txt |awk '{print $2}' ##### Print current quiz grade if exists ######
    echo "Is the current quiz grade."

fi
    
echo "Enter student's quiz grade."
read quiz
if [ "$quiz" -lt "0" ]; then
    echo "Invalid quiz grade!"        ####Check validity of user input#########
    exit 1
elif [ "$quiz" -gt "100" ]; then
    echo "invalid quiz grade!"
    exit 1
fi
gradeline="$gradeline $quiz"

if [ $alter -eq "1" ];then
    grep "$name" report.txt | awk '{print $3}' ##### Print current homework grade####
    echo "Is the current homework grade."
fi

echo "Enter student's homework grade."
read homework
if [ "$homework" -lt "0" ]; then
    echo "Invalid homework grade!"              ###take homework grade input######
    exit 1
elif [ "$homework" -gt "100" ]; then
    echo "Invalid homework grade!"
    exit 1
fi
gradeline="$gradeline $homework"

if [ $alter -eq "1" ];then
    grep "$name" report.txt | awk '{print $4}' #### print current midterm grade ######
    echo "Is the current midterm grade."
fi

echo "Enter student's midterm grade."
read midterm
if [ "$midterm" -lt "0" ]; then
    echo "Invalid midterm grade!"            ####take midterm grade input#####
    exit 1
elif [ "$midterm" -gt "100" ]; then
    echo "Invalid midterm grade!"
    exit 1
fi

gradeline="$gradeline $midterm"

if [ $alter -eq "1" ];then
    grep "$name" report.txt | awk '{print $5}' ###### print current final grade ######
    echo "Is the current final grade."
fi

echo "Enter student's final grade."
read final
if [ "$final" -lt "0" ];then
    echo "Invalid final grade!"          ###Take final grade input####
    exit 1
elif [ "$final" -gt "100" ]; then
    echo "Invalid grade type!"
    exit 1
fi
###################################################
####### Build score and letter grade line ##########
##################################################

gradeline="$gradeline $final"
Tgrade=$(echo $gradeline |awk -f grade.awk)
echo $Tgrade
gradeline="$gradeline $Tgrade"

if [ $alter -eq "1" ];then
    sed -i "/$name/d" report.txt
fi

echo $gradeline
echo $gradeline >> report.txt
cat report.txt


############
###END#####
###########
