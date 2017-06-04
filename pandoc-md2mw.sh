#!/bin/sh

# sed breakdown
#
#  :a;N;$!ba;
#    Read whole file and process it as a whole, instead of line-by-line.
#
#  s/|\n\n/|\n/g
#    Pandoc converts empty markdown cells to wiki cells with line breaks.
#    This eliminates those extra line breaks
#
#  s/width=".\{1,2\}%"//g
#    Pandoc needlessly inserts column widths (as percents)
#    Mediawiki and/or browsers do this well enough on their own, thank you very much
#
#  s/" |/"|/g
#    With the widths gone, there's now an extra space between 'align="center"' and '|'
#
#  s/\!|/\!/g
#    With the widths gone, some header cells now read "!|" when it should just be "!"
#
#  s/{|/{| class="wikitable sortable"/g
#    This makes the table sortable

pandoc --from markdown --to mediawiki pdsongs.md | \
  sed ':a;N;$!ba;s/|\n\n/|\n/g;s/width=".\{1,2\}%"//g;s/" |/"|/g;s/\!|/\!/g;s/{|/{| class="wikitable sortable"/g' > pdsongs.wiki
  
