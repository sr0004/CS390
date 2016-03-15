#AvgScript.awk average class grades
NR=1{
	Q+=$2
	H+=$3
	M+=$4
	F+=$5
	Total=(Q*0.1)+(H*0.4)+(M*0.2)+(F*0.3)

	 if(Total>=97 && Total<=100){letter="A+"}
	 else if(Total>=94 && Total<97){letter="A"}
	 else if(Total>=90 && Total<94){letter="A-"}
	 else if(Total>=87 && Total<90){letter="B+"}
	 else if(Total>=84 && Total<87){letter="B"}
	 else if(Total>=80 && Total<84){letter="B-"}
	 else if(Total>=77 && Total<80){letter="C+"}
	 else if(Total>=74 && Total<77){letter="C"}
	 else if(Total>=70 && Total<74){letter="C-"}
	 else if(Total>=67 && Total<70){letter="D+"}
	 else if(Total>=64 && Total<67){letter="D"}
	 else if(Total>=60 && Total<64){letter="D-"}
	 else if(Total>=0 && Total<60){letter="F"}


	

}

END {print Total, letter}

