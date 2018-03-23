# Amazon-FBA-Box-Label-Batch-Print  FBALabelConvert.bat

Windows "Batch" command to reformat Amazon FBA Box Shipping Labels PDF to a new PDF formatted for printing to a Zebra LP2844 Label Printer

Creating an Amazon FBA shipment results in one or more label sets; one set for each box in the shipment.  The set is formatted to a letter size page in a PDF.  That PDF [Package (nn).pdf] is typically opened by your browser or placed in your "Downloads" directory.  This process assumes that file is in your Downloads directory and you can select it with Windows Explorer.  

FBALabelConvert is initated from the right-click context menu after selecting the Package(nn).pdf.
It uses two 3rd party utilities, XPFREADER and IMAGE MAGIC, to do the conversion.
The resulting PDF is placed in the same location as Package(nn).pdf and opened (with default PDF reader)
It's formatted to be sent to a 4 x 6 label printer.

# Adding FBALabelConvert to the Context Menu  addcontextmenu.reg

Save this file then edit it to specify the location where you put FBALabelConvert.bat
Save your changes then "open" it (double-click?) to modify your Registry

# DEPENDANCIES

XPDFREADER / PDFIMAGES UTILITY from www.xpdfreader.com

MAGICK / IMAGE MAGIC COMMAND LINE UTILITY from www.imagemagick.org
