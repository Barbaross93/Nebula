#!/bin/bash -f

#
# command line bash shell script to convert PowerPoint pptx format to text on Mac, Linux or Unix
#

# pptx2txt usage message
pptx2txt_usage ()
{
  echo " "
  echo "USAGE: pptx2txt.sh [options] PPTX_FILENAME"
  echo " "
  echo "OPTIONS:"
  echo " "
  echo "  -v, --verbose     verbose output including filename and slide number heading"
  echo " "
  echo "  -h, --help        display this help message"
  echo " "
  exit 1
}

# echo error with usage
eu ()
{
        echo " "
        echo "ERROR: $1"
        pptx2txt_usage
}

# initialize flags and arguments
verbose=0
help=0

# loop over arguments
while [[ $# > 0 ]]
do
key="$1"
  case $key in
    -v|--verbose)
      verbose=1
      ;;
    -h|--help)
      help=1
      ;;
    *)
      if [ -e "$key"  ]
      then
        pptx_filename="$key"
      else
        eu "unknown option '$key'"
      fi;
      break
      ;;
  esac
  shift
done

# dislpay help if requested
if [ $help -eq 1  ]
then
  pptx2txt_usage
fi;

# detect empty PPTX_FILENAME
if [ -z "$pptx_filename" ];
then
  eu "No PPTX_FILENAME name detected."
else
  pptx_filename="$1"
fi;

# find number of slides in pptx file
nslides=`unzip -l "$pptx_filename" ppt/slides/slide*.xml | awk '{print $2}' | tail -1`

# echo PPTX_FILENAME and TOTAL SLIDE COUNT if verbose
if [ $verbose -eq 1 ]
then
  echo "PPTX_FILENAME = $pptx_filename"
  echo "TOTAL SLIDE COUNT = $nslides"
fi;

# loop over slide index
for idx in `seq 1 $nslides`;
  do

    if [ $verbose -eq 1 ]
    then
      echo " "
      echo "SLIDE $idx OF $nslides"
      echo " "
    fi;

    unzip -qc "$pptx_filename" ppt/slides/slide$idx.xml | perl -e 'while(<>) {  if (@list = ($_ =~ m/\<a:t\>(.+?)\<\/a:t\>/g)) { print "$_\n" for @list } }'

done

