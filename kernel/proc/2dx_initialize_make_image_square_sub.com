#
#
# this is not an independent script. It should only be called from other scripts.
#
# This sub-script will make sure the ${imagename}.mrc is square, by either padding or cropping it.
# It will also make sure the image size is an allowed product of small prime factors.
#
#
#
if ( ${movie_enable} == "y" ) then
    set loc_imagename = ${movie_imagename}
else
    set loc_imagename = ${imagename}
endif
#
    setenv IN ${loc_imagename}.mrc
    set dimens = `${bin_2dx}/header.exe | awk "/Number\ of\ columns/{print $1}" | cut -c51-`
    set sizeX = `echo ${dimens} | cut -d\  -f1` 
    set sizeY = `echo ${dimens} | cut -d\  -f2` 
    ${proc_2dx}/linblock "Image ${loc_imagename} has a size of ${sizeX},${sizeY}."
    if ( ${sizeX} != ${sizeY} ) then
      if ( ${movie_verbose}x != "0x" ) then
        ${proc_2dx}/linblock "ERROR: only square images are supported (${sizeX},${sizeY})."
        echo "#WARNING: ERROR: only square images are supported."  >> LOGS/${scriptname}.results
      endif
      #
      if( ${crop} == "0" ) then
        #############################################################################
        if ( ${movie_verbose}x != "0x" ) then
          ${proc_2dx}/linblock "Crop image into smaller square array"
          ${proc_2dx}/linblock "Crop image into smaller square array" >> History.dat
        endif
        #############################################################################
        #
        set newsize = `echo ${sizeX} ${sizeY} | awk '{ if ( $1 < $2 ) { s = $1 } else { s = $2 }} END { print s }'`
      else
        #############################################################################
        if ( ${movie_verbose}x != "0x" ) then
          ${proc_2dx}/linblock "Pad image into larger square array"
          ${proc_2dx}/linblock "Pad image into larger square array" >> History.dat
        endif
        #############################################################################
        #
        set newsize = `echo ${sizeX} ${sizeY} | awk '{ if ( $1 > $2 ) { s = $1 } else { s = $2 }} END { print s }'`
      endif
      if ( ${movie_verbose}x != "0x" ) then
        ${proc_2dx}/linblock "New image size will be ${newsize}"
        ${proc_2dx}/linblock "New image size will be ${newsize}" >> History.dat
      endif
      \rm -f SCRATCH/TMPnewsize.mrc
      #
      ${bin_2dx}/labelh.exe << eot
${loc_imagename}.mrc
30
SCRATCH/TMPnewsize.mrc
${newsize}
eot
      #
      if (  ${movie_enable} != "y" ) then  
        if ( ! -e ${loc_imagename}-original.mrc ) then
          \mv -f ${loc_imagename}.mrc ${loc_imagename}-original.mrc
        else
          ${proc_2dx}/linblock "${loc_imagename}-original.mrc already existing."
          ${proc_2dx}/protest "ERROR: Renaming not possible."
        endif
        echo "# IMAGE-IMPORTANT: ${loc_imagename}-orignal.mrc <Original Image>"  >> LOGS/${scriptname}.results
      endif
      \mv -f SCRATCH/TMPnewsize.mrc ${loc_imagename}.mrc
      #
      set sizeX = ${newsize}
      #
      #############################################################################
      if ( ${movie_verbose}x != "0x" ) then
        ${proc_2dx}/linblock "Testing new image size of ${sizeX} for prime factors"
      endif
      #############################################################################
      #
      set primesfile = SCRATCH/2dx_primes.dat  
      #
      \rm -f ${primesfile}
      #
      \rm -f 2dx_primes.out
      ${bin_2dx}/2dx_primes.exe << eot  > 2dx_primes.out
${sizeX}
${primesfile}
eot
      if ( ${movie_verbose}x != "0x" ) then
        cat 2dx_primes.out
        \rm -f 2dx_primes.out
      endif
      #
    else
      #############################################################################
      if ( ${movie_verbose}x != "0x" ) then
        ${proc_2dx}/lin "Testing new image size of ${sizeX} for prime factors"
      endif
      #############################################################################
      #
      set primesfile = SCRATCH/2dx_primes.dat  
      #
      \rm -f ${primesfile}
      #
      ${bin_2dx}/2dx_primes.exe << eot > SCRATCH/TMPprimesout.dat
${sizeX}
${primesfile}
eot
      #
      if ( ${movie_verbose}x != "0x" ) then
        if ( -e ${primesfile} ) then
          cat SCRATCH/TMPprimesout.dat
        else
          cat SCRATCH/TMPprimesout.dat | sed 's/::/:/g'
        endif
      endif
      \rm -f SCRATCH/TMPprimesout.dat
      #
    endif
    #
    if ( -e ${primesfile} ) then
      set bettersize = `cat ${primesfile} | head -n 1`
      set cropdimensions = `cat ${primesfile} | head -n 2 | tail -n 1`
      #
      #############################################################################
      if ( ${movie_verbose}x != "0x" ) then
        ${proc_2dx}/linblock "cutting image down into better smaller size of ${bettersize}"
        ${proc_2dx}/linblock "cutting image down into better smaller size of ${bettersize}" >> History.dat
      endif
      #############################################################################  
      #
      \rm -f SCRATCH/TMPnewsize1.mrc
      #
      ${bin_2dx}/labelh.exe << eot
${loc_imagename}.mrc
1
SCRATCH/TMPnewsize1.mrc
${cropdimensions}
eot
      #
      if ( ${movie_verbose}x != "0x" ) then
        ${proc_2dx}/linblock "Cropping done."
        #
        #############################################################################
        ${proc_2dx}/linblock "Pad into image with same dimensions to get the header right"
        #############################################################################
      endif
      #
      \rm -f SCRATCH/TMPnewsize2.mrc
      #
      ${bin_2dx}/labelh.exe << eot
SCRATCH/TMPnewsize1.mrc
30
SCRATCH/TMPnewsize2.mrc
${bettersize}
eot
      echo "<<@progress: 60>>"
      #
      ${proc_2dx}/lin "Padding done."
      #
      \mv -f SCRATCH/TMPnewsize2.mrc ${loc_imagename}.mrc
      #
      set sizeX = ${bettersize}
      #
      \rm -f SCRATCH/TMPnewsize1.mrc
      \rm ${primesfile}
    endif
    #
    set newsize = `echo ${sizeX} | awk '{ if ( $1 < 1024 ) { s = 2 * $1 } else { s = $1 }} END { print s }'`
    #
    if ( ${newsize} != ${sizeX} ) then
      #
      #############################################################################
      echo ":: "
      echo "::WARNING: Interpolating image up to ${newsize}"
      echo ":: "
      echo "#WARNING: WARNING: Image was up-interpolated two times, to ${newsize} pixels" >> LOGS/${scriptname}.results
      #############################################################################  
      #
      \rm -f SCRATCH/TMPnewsize1.mrc
      #
      ${bin_2dx}/labelh.exe << eot
${loc_imagename}.mrc
29
SCRATCH/TMPnewsize1.mrc
eot
      #
      if ( ${movie_verbose}x != "0x" ) then
        echo ":: "
        ${proc_2dx}/linblock "Interpolation done."
      endif
      #
      echo "<<@progress: 62>>"
      #
      if ( ! -e ORIGINAL.mrc ) then
        \mv -f ${loc_imagename}.mrc ORIGINAL.mrc
        echo "#IMAGE-IMPORTANT: ORIGINAL.mrc <Original image>" >> LOGS/${scriptname}.results
      endif
      #
      \mv -f SCRATCH/TMPnewsize1.mrc ${loc_imagename}.mrc
      #
      set sizeX = ${newsize}
      #
    endif
    #
    if ( ${sizeX} != ${imagesidelength} ) then
      set oldval = ${imagesidelength}
      set imagesidelength = ${sizeX}
      if ( ${movie_verbose}x != "0x" ) then
        ${proc_2dx}/linblock "WARNING: correcting imagesidelength from ${oldval} to ${imagesidelength}"
      endif
      echo "set imagesidelength = ${imagesidelength}"  >> LOGS/${scriptname}.results
    endif
    #



