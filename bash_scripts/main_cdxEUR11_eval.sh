# COREX-EUR11 processing script
# Inne Vanderkelen  18/04/2018

# =======================================================================
# initialisation
# =======================================================================



# set output directory
outDIR=$WORKDIR/ecotron/data_processed

# set starting directory
inDIR=/gpfs/projects/climate/data/dataset/cordex/EUR-11/evaluation/day

# set variable names
VARs=('hurs' 'huss' 'pr' 'ps' 'psl' 'rlds' 'rsds' 'sfcWind' 'sfcWindmax' 'tas' 'tasmax' 'tasmin' 'uas' 'vas')

INSTITUTEs=('CLMcom' 'CNRM' 'DHMZ' 'DMI' 'IPSL-INERIS' 'KNMI' 'MPI-CSC' 'RMIB-UGent' 'SMHI')

FORCING=('ECMWF-ERAINT')

RCMs=('CLMcom-CCLM4-8-17' 'CNRM-ALADIN53' 'DHMZ-RegCM4-2' 'DMI-HIRHAM5' 'IPSL-INERIS-WRF331F' 'KNMI-RACMO22E' 'MPI-CSC-REMO2009' 'RMIB-UGent-ALARO-0' 'SMHI-RCA4')

CLASS=('r1i1p1')


# ==============================================================================
# processing
# ==============================================================================

# go into climate directory

cd $inDIR
pwd

# loop to get into file directory
for VAR in "${VARs[@]}"; do
	if [ -d $VAR ]
        then    
	echo $VAR        

    for INSTITUTE in "${INSTITUTEs[@]}"; do
        if [ -d "$VAR/$INSTITUTE" ]
        then
                 echo $INSTITUTE 'exists'

               for RCM in "${RCMs[@]}"; do

                        if [ -d "$VAR/$INSTITUTE/$FORCING/$RCM/$CLASS" ]
                        then
                       
                        cdo mergetime $VAR/$INSTITUTE/$FORCING/$RCM/$CLASS/$VAR_*.nc $outDIR/evaluation/temp1.nc 
                        cdo sellonlatbox,5.34,6.06,50.78,51.22 $outDIR/evaluation/temp1.nc $outDIR/evaluation/temp2.nc
			
                        mv $outDIR/evaluation/temp2.nc  $outDIR/evaluation/${VAR}_ecotron_${RCM}_day_eval.nc
                        rm $outDIR/evaluation/temp1.nc 
			
                    
                        fi
                    done
                    
                fi
        
    
            done
            
            
        fi

done
   
