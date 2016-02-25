#!/bin/bash

outfile=`pwd`/hw2.out
echo "========================================================"
echo "This is CS390 assignment #2. Please response with the 
question with a command line. The command you entered and 
the output of the command will be saved in file 
$outfile "
echo "========================================================"

echo
echo -n "Please enter you name (first last): "
read student

tee << EOF > $outfile
===================================================
  Assignement Two 
  $student      
 `date "+%F %T" `
===================================================

EOF

echo "Please answer the following questions..."

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Command to find out your shell default umask:" | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read reply
echo $reply >> $outfile

$reply | tee -a $outfile

rm -rf hw2

echo 
echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Command to create directory hw2" | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read reply
$reply | tee -a $outfile

echo -e "\nYour current location:" `pwd` "\n" | tee -a $outfile
echo "Command to list the Content of current directory (long list):"
read reply
$reply | tee -a $outfile
echo 

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "What are the permissions (in letter) of directory hw2 based on the previous output?" | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read reply
echo $reply >> $outfile

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Give the above permissions in octave:" | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read reply

echo $reply >> $outfile
echo 

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Give the command to modify the permissions of directory hw2 so only you can access" | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read reply
echo $reply >> $outfile
$reply
echo 
ls -l | tee -a $outfile

echo "----------------------------------------------------------------------" | tee -a $outfile
echo  "What are the file permissions of file hw1/info.txt" | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read reply
echo $reply >> $outfile
ls -l hw1/info.txt |tee -a $outfile
echo 

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Give the command to add execution permission to hw1/info.txt to YOU only" | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read reply
echo $reply >> $outfile
echo 
ls -l hw1/info.txt |tee -a $outfile
echo 

cat << EOF >> $outfile

============================================================================
The following questions to exercise shell meta characters for file locating
============================================================================

EOF

echo "Change to directory $PWD/hw2"
pushd hw2

echo "----------------------------------------------------------------------" | tee -a $outfile
echo -e "\nDownload tarball ladsrc.tar.gz from class website...\n" | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
echo wget http://zeta.itsc.uah.edu/cs390/assignments/ladsrc.tar.gz | tee -a $outfile
wget http://zeta.itsc.uah.edu/cs390/assignments/ladsrc.tar.gz

ls -l
echo -e "\nCommand to decompress tarball ladsrc.tar.gz..."
read reply
$reply

echo 
status=$?
if [[ $status -ne 0 ]]; then
   echo "retrieving ladsrc.tar.gz failed, aborting..."
   exit 1
fi

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Give cmd to create directories a-gFiles h-oFiles p-zFiles include " | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
echo "(You might want to use -p option in case the directory already exists)"
read cmd
echo $cmd | tee -a $outfile
$cmd

for dir in a-gFiles h-oFiles p-zFiles include; do
    if [[ ! -d $dir ]]; then
        echo "Create directory $dir failed, aborting..." | tee -a $outfile
        exit 1
    fi
done

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Copy all the .c files (in ladsrc) starting with letter [a-g] to directory a-gFiles " | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read cmd
echo $cmd >>  $outfile
$cmd    
echo "files in a-gFiles" | tee -a $outfile
ls -1 a-gFiles | tee -a $outfile

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Copy all the .c files starting withletter [h-o] to directory h-oFiles " | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read cmd
echo $cmd >>  $outfile
$cmd    
echo "files in h-oFiles" | tee -a $outfile
ls -1 h-oFiles | tee -a $outfile

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Copy all the .c files starting withletter [p-z] to directory p-zFiles " | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read cmd
echo $cmd >>  $outfile
$cmd    
echo "files in p-zFiles" | tee -a $outfile
ls -1 p-zFiles | tee -a $outfile

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Copy all header file (.h) to directory include " | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read cmd
echo $cmd >>  $outfile
$cmd    
echo "files in include" | tee -a $outfile
ls -1 include | tee -a $outfile

echo "current directory:$PWD"
#echo "----------------------------------------------------------------------" | tee -a $outfile
#for dir in ladsrc a-gFiles h-oFiles p-zFiles include; do
#    echo "Command to count the number of files in $dir directory" | tee -a $outfile
#    read cmd
#    while [[ -z $cmd ]]; do
#        read cmd   
#    done
#    echo "$cmd" >> $outfile
#    nlines=`$cmd`
#    echo $nlines| tee -a $outfile
#done

echo "----------------------------------------------------------------------" | tee -a $outfile
echo "Using find command to list files of size larger than 10kB under directory ladsrc " | tee -a $outfile
echo "----------------------------------------------------------------------" | tee -a $outfile
read cmd
while [[ -z $cmd ]]; do
    read cmd   
done
echo $cmd  | tee -a $outfile
$cmd | xargs ls -lh | tee -a $outfile

echo "----------------------------------------------------------------------"
echo "Congratulations! You have finished assignment 2.  Here is your $outfile:"
echo "Please print $outfile and turn in at beginnig of class on the due date!"
id >> $outfile
uname -a >> $outfile
echo

