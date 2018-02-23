#!/bin/csh -f

#
#	Shell script to get 500px page downloaded
#	&& give that http file to PERL to further process it -> Perl will download the actual HD-image
#	place that downloaded image in to .backup folder
#
#	Phani Tallapureddy, Fri Sep 16 18:17:02 IST 2016

echo	""
echo	"**********************************************************************"

echo	"wget -q --no-check-certificate -c 'http://500px.com/photo/$1'"
wget -q	--no-check-certificate -c "http://500px.com/photo/$1"

set	URL_file	= `ls -1t | grep -v csh | grep -v plx | head -1`
echo	"perl	process_500px.plx	$URL_file"
perl	process_500px.plx	$URL_file

echo	"**********************************************************************"
echo	""
