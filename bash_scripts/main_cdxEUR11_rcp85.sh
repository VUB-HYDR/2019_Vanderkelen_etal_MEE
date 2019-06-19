# COREX-EUR11 processing script
# Inne Vanderkelen  18/04/2018

# =======================================================================
# initialisation
# =======================================================================


# set output directory
outDIR=$WORKDIR/ecotron/data_processed/rcp85/

# set starting directory
inDIR=/gpfs/projects/climate/data/dataset/cordex/EUR-11/rcp85/day

# set variable names

#VARs=('tas')
VARs=('hurs' 'huss' 'pr' 'ps' 'psl' 'rlds' 'rsds' 'sfcWind' 'sfcWindmax' 'tas' 'tasmax' 'tasmin' 'uas' 'vas')

#INSTITUTEs=('CLMcom')
INSTITUTEs=('CLMcom' 'CNRM' 'DHMZ' 'DMI' 'IPSL-INERIS' 'KNMI' 'MPI-CSC' 'RMIB-UGent' 'SMHI')

#FORCINGs=('CNRM-CERFACS-CNRM-CM5')
FORCINGs=('CNRM-CERFACS-CNRM-CM5' 'ICHEC-EC-EARTH' 'MOHC-HadGEM2-ES' 'MPI-M-MPI-ESM-LR' 'NCC-NorESM1-M' 'IPSL-IPSL-CM5A-MR')

#RCMs=('CLMcom-CCLM4-8-17')

RCMs=('CLMcom-CCLM4-8-17' 'CNRM-ALADIN53' 'DHMZ-RegCM4-2' 'DMI-HIRHAM5' 'IPSL-INERIS-WRF331F' 'KNMI-RACMO22E' 'MPI-CSC-REMO2009' 'RMIB-UGent-ALARO-0' 'SMHI-RCA4')

CLASSes=('r1i1p1' 'r12i1p1')


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
                 
            for FORCING in "${FORCINGs[@]}"; do 
                if [ -d "$VAR/$INSTITUTE" ]
                then
                   echo $FORCING 'exists'

                    for RCM in "${RCMs[@]}"; do
               
                        for CLASS in "${CLASSes[@]}"; do

                            if [ -d "$VAR/$INSTITUTE/$FORCING/$RCM/$CLASS" ]
                            then
                       
			cdo mergetime $VAR/$INSTITUTE/$FORCING/$RCM/$CLASS/$VAR_*.nc $outDIR/temp1.nc 
			cdo sellonlatbox,5.34,6.06,50.78,51.22 $outDIR/temp1.nc $outDIR/temp2.nc
			
			mv $outDIR/temp2.nc $outDIR/${VAR}_ecotron_${FORCING}-${RCM}_day_rcp85.nc
			rm $outDIR/temp1.nc 
			
                    
                            fi
                        done
                    done
                    
                fi
        
            done
            
         fi
     done
            
  fi

done
   
