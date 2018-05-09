#!/bin/csh -f

#
#       Shell script to get 500px page downloaded
#       && give that http file to PERL to further process it -> Perl will download the actual HD-image
#       place that downloaded image in to .backup folder
#
#       Phani Tallapureddy, Fri Sep 16 18:17:02 IST 2016
#
#
# v1.0  : used wget command
# v2.0  : used perl LWP module getprint

echo    ""
echo    "**********************************************************************"

echo    "parsing html page -> http://www.500px.com/photo/$1"
perl -MLWP::Simple -e "getprint 'http://www.500px.com/photo/$1'" >& $1.html

echo    "parsing image url page for HD-image"
perl  process_500px.plx $1.html

echo    "**********************************************************************"
echo    ""
