#!/usr/bin/perl

#
#	perl script to grep HD-image from 500px.URL page provided as argument && download it
#	also, add the file_type extension too
#
#	Phani Tallapureddy, Fri Sep 16 15:24:04 IST 2016

$|=1;

##	HTML page is the input argument
$urlfile_in	= $ARGV[0];

open	(FIN, "<", $urlfile_in) || die "Cannot open $!";
@array		= <FIN>;
close	(FIN);

foreach	$line (@array)
{
	if ($line =~ m/,"images":\[(\S+)\],/i)
	{
		@array_size		=	();
		@array_url		=	();
		@array_type		=	();

		$line_found 		= 	1;
		$sub_line		=	$1;

		@split_line		=	split(/,/, $sub_line);
		$length_split		=	$#split_line;

		for ($i=0; $i <= $length_split; $i++)
		{
			$temp_key_value	= 	$split_line [$i];
			$temp_key_value =~ 	s/\[//g;
			$temp_key_value =~ 	s/\]//g;
			$temp_key_value =~ 	s/{//g;
			$temp_key_value =~ 	s/}//g;
			$temp_key_value =~ 	s/"//g;
			$temp_key_value =~ 	s/\\//g;

			if ($temp_key_value =~ m/size/i)
			{
				@temp	=	split (/:/, $temp_key_value); 
				$push1	=	"$temp[1]";
				push	(@array_size, $push1);

				#print	STDOUT	"\n 1-> $push1";
			}

			if ($temp_key_value =~ m/https_url/i)
			{
				@temp	=	split (/:/, $temp_key_value); 
				$push2	=	"$temp[1]:"."$temp[2]";
				push	(@array_url, $push2);

				#print	STDOUT	"\n 2-> $push2";
			}

			if ($temp_key_value =~ m/format/i)
			{
				@temp	=	split (/:/, $temp_key_value); 
				$push3	=	"$temp[1]";
				push	(@array_type, $push3);

				#print	STDOUT	"\n 3-> $push3";
			}
		}

	}
	else
	{
		next;
	}
}

##	get jpeg/jpg/png format from the HTML file itself
$file_type	= $array_type[$#array_type];

##	get ready with output filename, << pic-number >> . << file_type >>
$new_file_name	= "$urlfile_in".".$file_type";
$new_file_name	=~ s/.html//;

##	last element in the list is the HD-quality
$link 		= $array_url[$#array_url];

##	run the actual wget command for specific HD-quality pic link
system 	("wget", "-q", " --no-check-certificate ", " -c ", "$link");

##	downloaded pic will have strange name,
##	rename it to pre-configured output filenaming
$temp_dn_file	= `ls -1t | grep -v -P "(html|csh|txt|md|plx)" | head -1`;
chomp	$temp_dn_file;
system	("mv", "$temp_dn_file", "$new_file_name");

##	delete the URL / HTML file
##	move the downloaded pic to folder
system	("mv", $urlfile_in, ".backup/");
system	("mv", $new_file_name, ".backup/");

##	read resolution of the pic downloaded && its size
system	("rdjpgcom -verbose .backup/$new_file_name");
system	("du -sh .backup/$new_file_name");


