
CC = g++

qsalary: employee.o main.o
	g++ employee.o main.o -o qsalary

employee.o: employee.cpp employee.h
	g++ -c employee.cpp

main.o: main.cpp employee.h
	g++ -c main.cpp

clean:
	rm *.o










