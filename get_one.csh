#!/bin/csh -f

#
#	Shell script to get 500px page downloaded
#	&& give that http file to PERL to further process it -> Perl will download the actual HD-image
#	place that downloaded image in to .backup folder
#
#	Phani Tallapureddy, Fri Sep 16 18:17:02 IST 2016
#
#
# v1.0  : used wget command
# v2.0  : used perl LWP module getprint

echo	""
echo	"**********************************************************************"

perl -MLWP::Simple -e "getprint 'http://www.500px.com/photo/$1'" > & link.html
perl  process_500px.plx	link.html
\rm   link.html

echo	"**********************************************************************"
echo	""
