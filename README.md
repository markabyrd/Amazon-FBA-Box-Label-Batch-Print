# Amazon-FBA-Box-Label-Batch-Print  FBALabelConvert.bat

Windows "Batch" command to reformat Amazon FBA Box Shipping Labels PDF to a new PDF formatted for printing to a Zebra LP2844 Label Printer

Creating an Amazon FBA shipment results in one or more label sets; one set for each box in the shipment.  The set is formatted to a letter size page in a PDF.  That PDF [Package (nn).pdf] is typically opened by your browser or placed in your "Downloads" directory.  This process assumes that file is in your Downloads directory and you can select it with Windows Explorer.  

FBALabelConvert is initated from the right-click context menu after selecting the Package(nn).pdf.
It uses 3rd party utilities; XPFREADER; IMAGE MAGIC, and GHOSTSCIPT to do image conversion.
The resulting PDF is placed in the same location as Package(nn).pdf and opened (with default PDF reader)
It's formatted to be sent to a 4 x 6 label printer.

# Installing FBALabelConvert.bat

Copy FBALabelConvert.bat file to c:\Windows

# Adding FBALabelConvert to the Context Menu  addcontextmenu.reg

"open" addcontextmenu.reg (double-click?) to modify your Registry

# DEPENDANCIES

XPDFREADER / XPDFTOOLS / PDFIMAGES UTILITY from www.xpdfreader.com 
  Link: [https://xpdfreader-dl.s3.amazonaws.com/xpdf-tools-win-4.00.zip]

MAGICK / IMAGE MAGIC COMMAND LINE UTILITY from www.imagemagick.org
  Link: ftp://ftp.imagemagick.org/pub/ImageMagick/binaries/ImageMagick-7.0.7-28-Q16-x64-dll.exe
  
GHOSTSCRIPT from www.ghostscript.com
  Link: https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs923/gs923w64.exe

If these utilities are not present on your system, you must find, download and install them.

# Error Handling

Minimal (its a batch file).  The Command Shell window closes when the converted PDF is closed.  If the converted PDF is
not closed when FBALabelConvert is excuted, it may not produce a new output file.  If there are error messages, you may 
want to try running FBALabelConvert from the command line.  

c:\Users\<username>\Downloads>fbalabelconvert package.pdf
