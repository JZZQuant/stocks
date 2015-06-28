#!/bin/sh

R CMD BATCH extract.R
R CMD BATCH transform.R
R CMD BATCH load.R

# Print logs out if triggered from console
if [ "$2" = "true" -o  $# -eq 0 ]
then
cat extract.Rout
cat transform.Rout
cat load.Rout
else
mv *.Rout $1
mv *.Rdata $1
fi

