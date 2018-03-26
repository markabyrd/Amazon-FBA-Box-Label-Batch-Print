@ECHO OFF

:: BATCH PRINT FBA SHIPPING LABELS TO ZEBRA LP2844 4x6 THERMAL PRINTER
:: Mark Byrd, Net Sells It inc [mark.byrd@netsellsit.com]

:: INSTALLATION
:: 1) Copy this .BAT file to C:\Windows
:: 2) Update the Registry to launch it from the context menu
:: 3) Check the "dependancies" to be sure the 3rd party utilities are installed
:: 
:: USAGE
:: Let Amazon "Print" the FBA Shipping Lables PDF
:: Browse the file location (downloads?) where your browser put it
:: Select the FBA Shipping Labels PDF downloaded from Amazon
:: Right-Click and click this FBALabelConvert command in the Context Menu
::
:: OUTPUT
:: CMD window will open and display some progress messages
:: A new PDF repaginated with 1 lable per page will be place where he input file came from
:: The output file will be opened in Acrobat Reader ready for you to send to your Zebra
::
:: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: ADD BATCH FILE TO CONTEXT MENU
::
:: Copy, edit to remove comments, and specify the location of FBALabelConvert.bat
:: then save the following 4 lines as "AddToContext.reg"
:: browse to that file and double-click to update the Registry
:: ---------------------------------------------------------------------------
:: Windows Registry Editor Version 5.00
:: [HKEY_CLASSES_ROOT\*\shell\FBALabelConvert]
:: [HKEY_CLASSES_ROOT\*\shell\FBALabelConvert\command]
:: @="\"C:\\Windows\\FBALabelConvert.bat\" \"%1\""
:: ---------------------------------------------------------------------------
::
:: DEPENDANCIES
:: 
:: XPDFREADER / XPDFTOOLS / PDFIMAGES UTILITY from www.xpdfreader.com 
::   Link: [https://xpdfreader-dl.s3.amazonaws.com/xpdf-tools-win-4.00.zip]
::
:: MAGICK / IMAGE MAGIC COMMAND LINE UTILITY from www.imagemagick.org
::   Link: ftp://ftp.imagemagick.org/pub/ImageMagick/binaries/ImageMagick-7.0.7-28-Q16-x64-dll.exe
::  
:: GHOSTSCRIPT from www.ghostscript.com
::   Link: https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs923/gs923w64.exe
:: 
:: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SET iam=%~n0
ECHO %iam%: Starting ...
SET args=%*
IF NOT DEFINED args GOTO NOARGSEND

ECHO %iam%: called with the following argument: %*

:: set global variables
:: temporary space to hold the image files
:: filename of Amazon PDF is 1st / only argument
:: need the path to put the result PDF back
:: Output PDF name
SET tempdir=%temp%\FBALabelConvert
SET outpath=%CD%          
SET outname=FBAlabels.pdf

ECHO %iam%: Output going to %outname%
ECHO %iam%: Working directory is %tempdir%
ECHO %iam%: Set up / clean up a temorary directory  %tempdir%

MD %tempdir%
DEL /Q %tempdir%\*.PPM
DEL /Q %tempdir%\*.PBM
DEL /Q %tempdir%\*.PNG
DEL /Q %tempdir%\*.PDF

COPY %1 %tempdir%\AmzFBA.pdf

ECHO %iam%: Using PDFIMAGES utility to extract label images from Amazon's PDF...
PDFIMAGES -j %tempdir%\AmzFBA.pdf %tempdir%\xxx

ECHO %iam%: Using MAGICK CONVERT to rotate, crop, resize each (.PPM) UPS label.  Output PNG images at 800 x 1204
SET /a c=1
SETLOCAL ENABLEDELAYEDEXPANSION
FOR %%f IN (%tempdir%\*.ppm) DO (
    MAGICK convert %%f -gravity west -crop 86x100%%+0+0 -rotate 90 %tempdir%\UPS_!c!.png
    SET /a c=c+1
)
ENDLOCAL

ECHO %iam%: Using MAGICK CONVERT to cut out each FBA box label from the PDF.  Output PNG images at 800 x 1024
MAGICK convert -density 400 %tempdir%\AmzFBA.pdf  -colorspace gray -gravity northwest -alpha off -crop 50x48%%+0+150 -resize 800x1204 %tempdir%\FBA.png

ECHO %iam%: Using MAGICK to Combine images into a single PDF, each page is set to be 800x1204 to avoid any resizing
:: DEL  %tempdir%\%outname%
MAGICK convert %tempdir%\*.png -colorspace gray -density 203 -repage 800x1204+0+0 %tempdir%\%outname%

copy %tempdir%\%outname%
%outname%

GOTO END

:NOARGSEND
ECHO %iam%: ERROR: No PDF argument
PAUSE

:END
ECHO %iam%: END
