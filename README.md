## vcardsearch

lbdb is all kinds of broken for vCard parsing and Contacts.app (macOS)
access. This can be used with the mutt query command to do roughly the
same function. 

## requires

* perl
* Text::vCard::Addressbook
* utf-8
* a vCard file

## usage
```
   Search a vCard format file and return data formatted for mutt

   usage: vcardsearch.pl [-h] [-c] [-f vcf file] [-s search term]
     -h        : this help message
     -c        : check for CJK names and return LASTFIRST
     -f        : the vCard file to parse
     -s        : the search term (UTF-8 compliant)

   example: 
   vcardsearch.pl -f /home/ca/.mutt/vcards.vcf -s guenther
   vcardsearch:    1 match(es)
   procmail4life@openbsd.org      Philip Guenther
```
## Configure mutt
```
set query_command="vcardsearch.pl -f $HOME/.mutt/vCards.vcf -c -s '%s'"
```
## Export vCards

You can use the provided exportvcards.scpt to quickly export all
Contacts to Documents/vCards.vcf. Thanks to SPiFF for the fixes.

Usage:
```
osascript exportvcards.scpt
```
