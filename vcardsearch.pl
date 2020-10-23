#!/opt/local/bin/perl

use Encode qw(decode_utf8);
use utf8;
use Text::vCard::Addressbook;
use Getopt::Std;

#parse input as UTF-8
@ARGV = map { decode_utf8($_, 1) } @ARGV;
#output is also UTF-8
binmode STDOUT, ":encoding(UTF-8)";

my ($matchcount, $searchterm, @addresses, $vcffile, $cjk); 

sub usage {
   print STDERR << "EOF";

   Search a vCard format file and return data formatted for mutt

   usage: $0 [-h] [-c] [-f vcf file] [-s search term]
     -h        : this help message
     -c        : check for CJK names and return LASTFIRST
     -f        : the vCard file to parse
     -s        : the search term (UTF-8 compliant)

   example: 
   $0 -f /home/ca/.mutt/vcards.vcf -s guenther
   vcardsearch:    1 match(es)
   procmail4life\@openbsd.org      Philip Guenther

EOF
   exit;
}

sub init {
   getopts('hf:s:c');
   &usage if $opt_h;
   &usage if !$opt_f or !$opt_s; 
   $searchterm = $opt_s;
   if (! -f "$opt_f") {
      print "Cannot open $opt_f - exiting\n";
      exit;
   }
   $vcffile = $opt_f;
}

sub checkcjk {
   local $_ = shift;
   $cjk = 1 if /\p{Hiragana}|\p{Katakana}|\p{Han}/;
}

&init;

my $address_book = Text::vCard::Addressbook->new({ 
  source_file => $vcffile
});

foreach my $vcard ( $address_book->vcards() ) {
   if ( $vcard->fullname() =~ /$searchterm/i || $vcard->email() =~ /$searchterm/i ) {
      &checkcjk($vcard->fullname()) if $opt_c;
      my $emailaddresses = $vcard->get( { 'node_type' => 'email' } );
      foreach my $email ( @{$emailaddresses} ) {
         $matchcount++;
         # this is the format that mutt expects
         # reverse name order for CJK and remove spaces
         if ( $cjk eq 1 ) {
            my ($first, $last)  = split(/ /, ($vcard->fullname()));
            push(@addresses, $email->value() . "\t" . $last . $first  . "\n");
         } else {
            push(@addresses, $email->value() . "\t" . $vcard->fullname() . "\n");
         }
      }  
   }
}

# mutt expects a match count line followed by matches
# this should display nicely with the tab completion To input
print "vcardsearch:" . "\t" . "$matchcount match(es)\n";
foreach my $emailaddress (@addresses) {
   print $emailaddress;
}
