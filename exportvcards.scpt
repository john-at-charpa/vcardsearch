set documentPath to (path to the documents folder as string)
alias documentPath
tell application "Contacts"
   set outFile to (open for access file (documentPath & "vCards.vcf") with write permission)
   repeat with cardPerson in people
      write (vcard of cardPerson as text) to outFile as «class utf8» starting at eof
   end repeat
   close access outFile
quit
end tell
