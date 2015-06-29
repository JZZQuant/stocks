#!/bin/sh

R CMD BATCH extract.R
R CMD BATCH transform.R
R CMD BATCH Load.R

mv *.Rout $1
mv *.Rdata $1