
   Search a vCard format file and return data formatted for mutt

   usage: Documents/src/vcardsearch.pl [-h] [-c] [-f vcf file] [-s search term]
     -h        : this help message
     -c        : check for CJK names and return LASTFIRST
     -f        : the vCard file to parse
     -s        : the search term (UTF-8 compliant)

   example: 
   Documents/src/vcardsearch.pl -f /home/ca/.mutt/vcards.vcf -s guenther
   vcardsearch:    1 match(es)
   procmail4life@openbsd.org      Philip Guenther

