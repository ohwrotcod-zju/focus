#
#############################################################################
#                                                                           #
# This is not an executable script.                                         #
#                                                                           #
# This should be sourced from the calling script.                           #
#                                                                           #
# (C) 2dx.org, GNU Plublic License.                                         #
#                                                                           #
# Created..........: 01/03/2007                                             #
# Last Modification: 01/03/2007                                             #
# Author...........: 2dx.org                                                #
#                                                                           #
#############################################################################
#
#
echo ": "
${proc_2dx}/lin "revhk_modus            = ${revhk_modus}"
${proc_2dx}/lin "rot90_modus            = ${rot90_modus}"
${proc_2dx}/lin "rot180_modus           = ${rot180_modus}"
${proc_2dx}/lin "sgnxch_modus           = ${sgnxch_modus}"
${proc_2dx}/lin "revhnd_modus           = ${revhnd_modus}"
${proc_2dx}/lin "revxsgn_modus          = ${revxsgn_modus}"
${proc_2dx}/lin "invert_tiltangle_modus = ${invert_tiltangle_modus}"
#
set scriptBfile = "SCRATCH/2dx_refine_scriptB.com"
\rm -f ${scriptBfile}
#
#############################################################################
${proc_2dx}/lin "Compile refinement script"
#############################################################################
#
set scriptBfile = "SCRATCH/2dx_merge_scriptB.com"
\rm -f ${scriptBfile}
set postprocessingfile = "SCRATCH/2dx_merge_postprocessing.com"
\rm -f ${postprocessingfile}
#
set genref = "1"
#
\rm -f LOGS/${scriptname}-tmp.results
#
if ( ${refbeamtilt} == 'y' ) then
  set NBM = T
  ${proc_2dx}/lin "NBM=T, doing beam tilt refinement."
else
  set NBM = F
  ${proc_2dx}/lin "NBM=F, no beam tilt refinement."
endif
#
if ( ${reftiltgeo} == 'y' ) then
  set NTL = T
  ${proc_2dx}/lin "NTL=T, doing crystal tiltangle and tiltaxis refinement."
else
  set NTL = F
  ${proc_2dx}/lin "NTL=F, no crystal tiltangle or tiltaxis refinement."
endif
#
${bin_2dx}/2dx_merge_compileB.exe << eot
LOGS/${scriptname}-tmp.results
${proc_2dx}
${bin_2dx}
${dirfile}
${scriptBfile}
${postprocessingfile}
${genref}
${spcgrp}
${realcell}
${realang}
${zstarwin}
${ALAT}
${IVERBOSE}
${MergeStepSize}
${RFACAMP}
${IBOXPHS}
${NPRG}
${NBM}
${NTL}
${MergeIQMAX}
${MergeHKMAX}
${RESMIN}
${RESMAX}
1
${revhk_modus}
${rot90_modus}
${rot180_modus}
${sgnxch_modus}
${revhnd_modus}
${revxsgn_modus}
${invert_tiltangle_modus}
eot
#
############################################################################
${proc_2dx}/lin "Launch refinement script"
#############################################################################
#
echo "# IMAGE: ${scriptBfile} <CSH: refinement script>" >> LOGS/${scriptname}.results
echo "# IMAGE: SCRATCH/2dx_merge_scriptB.log <LOG: origtilt B output>" >> LOGS/${scriptname}.results
chmod +x ${scriptBfile}
set logfile = SCRATCH/2dx_merge_scriptB_${currentline}_${number}.log
${scriptBfile} > ${logfile}
# cat ${logfile}
echo "# IMAGE: ${logfile} <LOG: Refinement Output ${currentline} ${number} >" >> LOGS/${scriptname}.results
#
echo "################################################"
echo "################################################"
echo "output in file ${logfile}"
echo "################################################"
echo "################################################"
#
if ( -s LOGS/${scriptname}-tmp.results ) then
  set MergePhaseResidual = `cat LOGS/${scriptname}-tmp.results | grep MergePhaseResidual | cut -d\" -f2` 
  set phaori             = `cat LOGS/${scriptname}-tmp.results | grep "phaori "          | cut -d\" -f2` 
  # set phaoriFouFilter    = `cat LOGS/${scriptname}-tmp.results | grep phaoriFouFilter    | cut -d\" -f2` 
  set phaori_last_change = `cat LOGS/${scriptname}-tmp.results | grep phaori_last_change | cut -d\" -f2` 
  echo ":MergePhaseResidual = ${MergePhaseResidual}"
else
  ${proc_2dx}/lin "ERROR: LOGS/${scriptname}-tmp.results not existing or zero length."
  set MergePhaseResidual = "nan"
endif
#