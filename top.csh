#!/bin/csh -f

##
##      Top-level wrapper to go through "links_to_get.txt" and download images one after another
##

#       source get_one.csh      161732299

foreach image_no (`cat links_to_get.txt`)
        source get_one.csh      $image_no
end


