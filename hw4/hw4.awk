#Swag errday
BEGIN{}
################################
#check for type field errors before running
################################
NR>1{
#Check for Exam field type
if($2 != "q"&&$2 != "Q"){
fielderrorfound[$1]="Quiz not found"
type[$1]=$2
error+=1
}

#Check for Exam field type
else if ($4 != "H"&& $4 !="h"){
fielderrorfound[$1]="Homework not found"
type[$1]=$4
error+=1
}

#Check for Exam field type
else if ($6!= "e"&& $6 != "E"){
fielderrorfound[$1]="Exam not found"
type[$1]=$6
error+=1
}

#Check for Final field type
else if ($8 != "F"&& $8 != "f"){
fielderrorfound[$1]="Final not found"
type[$1]=$8
error+=1
}

#Check for missing grade
IGNORECASE=1
if(($3 ~ /[A-Z]+/)||($5 ~ /[A-Z]+/)||($7 ~ /[A-Z]+/)||($9 ~ /[A-Z]+/)){grademissing[$1]=1

error+=1}
IGNORECASE=0



}


################################
#numerical grade for individuals
################################
NR>1 {student[$1]+=($3*0.1 + $5*0.4 + $7*0.2 + $9*0.3)
if (student[$1]<0||student[$1]>100){gradeerror[$1]=1
error+=1
}

}


################################
#numerical grade for class
################################
NR>1 {
	classQ+=$3
	classH+=$5
	classE+=$7
	classF+=$9}

################################
#Function to turn numeric averages to letter grades
################################
function n2a(classX,str){
 if(classX>=97 && classX<=100){letter[$1]="A+"}
 else if(classX>=94 && classX<=96){cletter="A"}
 else if(classX>=90 && classX<=93){cletter="A-"}
 else if(classX>=87 && classX<=89){cletter="B+"}
 else if(classX>=84 && classX<=86){cletter="B"}
 else if(classX>=90 && classX<=83){cletter="B-"}
 else if(classX>=77 && classX<=79){cletter="C+"}
 else if(classX>=74 && classX<=76){cletter="C"}
 else if(classX>=70 && classX<=73){cletter="C-"}
 else if(classX>=67 && classX<=69){cletter="D+"}
 else if(classX>=64 && classX<=66){cletter="D"}
 else if(classX>=60 && classX<=63){cletter="D-"}
 else if(classX>=0 && classX<60){cletter="F"}

 if(str==""){print "Class average", classX, cletter}
 else {print "Class", str, "average", classX, cletter}
}



################################
#letter grade for individuals
################################
NR>1{ if(student[$1]>=97 && student[$1]<=100){letter[$1]="A+"}
 else if(student[$1]>=94 && student[$1]<=96){letter[$1]="A"}
 else if(student[$1]>=90 && student[$1]<=93){letter[$1]="A-"}
 else if(student[$1]>=87 && student[$1]<=89){letter[$1]="B+"}
 else if(student[$1]>=84 && student[$1]<=86){letter[$1]="B"}
 else if(student[$1]>=90 && student[$1]<=83){letter[$1]="B-"}
 else if(student[$1]>=77 && student[$1]<=79){letter[$1]="C+"}
 else if(student[$1]>=74 && student[$1]<=76){letter[$1]="C"}
 else if(student[$1]>=70 && student[$1]<=73){letter[$1]="C-"}
 else if(student[$1]>=67 && student[$1]<=69){letter[$1]="D+"}
 else if(student[$1]>=64 && student[$1]<=66){letter[$1]="D"}
 else if(student[$1]>=60 && student[$1]<=63){letter[$1]="D-"}
 else if(student[$1]>=0 && student[$1]<60){letter[$1]="F"}
}




END{	


######Idividual Grades#######################

	print "---------------------"
	print "Individual Grades:"
	print "---------------------"

	if((fielderrorfound["John"]==0)&&(gradeerror["John"]==0)){
	print "John", student["John"], letter["John"]}
	else if(grademissing["John"]==1){print "John missing a grade"}
	else if(fielderrorfound["John"]!=0){print "John", fielderrorfound["John"], type["John"], "found instead."}
	else if(gradeerror["John"]==1){print "John Score not within 0-100"}
	else if(grademissing["John"]==1){Print"John missing a grade"}

	if((fielderrorfound["Jane"]==0)&&(gradeerror["Jane"]==0)){
	print "Jane", student["Jane"], letter["Jane"]}
	else if(grademissing["Jane"]==1){print "Jane missing a grade"}
	else if(fielderrorfound["Jane"]!=0){print "Jane", fielderrorfound["Jane"], type["Jane"], "found instead."}
	else if(gradeerror["Jane"]==1){print "Jane Score not within 0-100"}

	if((fielderrorfound["George"]==0)&&(gradeerror["George"]==0)){
	print "George", student["George"], letter["George"]}
	else if(grademissing["George"]==1){print "George missing a grade"}
	else if(fielderrorfound["George"]!=0){print "George", fielderrorfound["George"], type["George"], "found instead."}
	else if(gradeerror["George"]==1){print "George Score not within 0-100"}

	if((fielderrorfound["Cindy"]==0)&&(gradeerror["Cindy"]==0)){
	print "Cindy", student["Cindy"], letter["Cindy"]}
	else if(grademissing["Cindy"]==1){print "Cindy missing a grade"}
	else if(fielderrorfound["Cindy"]!=0){print "Cindy", fielderrorfound["Cindy"], type["Cindy"], "found instead."}
	else if(gradeerror["Cindy"]==1){print "Cindy Score not within 0-100"}

####Class Calculations###########################

	classQ=classQ/4
	classH=classH/4
	classE=classE/4
	classF=classF/4	
	classA=(student["John"]+student["Jane"]+student["George"]+student["Cindy"])/4

	print "---------------------"
	print " Class Averages: "
	print "---------------------"

if(error==0){
	print "Number of students = 4"
	n2a(classQ,"quiz")
	n2a(classH,"homework")
	n2a(classE,"exam")
	n2a(classF,"final")
	n2a(classA, "")
}else {print "Class average not calculated due to errors!"}

}

