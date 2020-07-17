# CCLM_EC-EARTH 3h data processing script
# Inne Vanderkelen  16/03/2018

# =======================================================================
# initialisation
# =======================================================================

# set output directory
outDIR=$WORKDIR/ecotron/data_processed/CCLM_EC-EARTH_3h/

# set starting directory
inDIR=/gpfs/projects/climate/data/dataset/cordex/EUR-11/rcp85/3hr/

# set variable names

#VARs=('pr')
VARs=('PMSL' 'ALWD_S' 'ASWD_S' 'ALHFL_S' 'ASHFL_S' 'T_2M' 'TOT_PREC' 'QV_2M' 'WSS_10M') 
YEARs=('2006' '2007' '2008' '2009' '2010' '2011' '2012' '2013' '2014' '2015'\
       '2016' '2017' '2018' '2019' '2020' '2021' '2022' '2023' '2024' '2025'\
       '2026' '2027' '2028' '2029' '2030' '2031' '2032' '2033' '2034' '2035'\
        '2036' '2037' '2038' '2039' '2040' '2041' '2042' '2043' '2044' '2045'\
        '2046' '2047' '2048' '2049' '2050' '2051' '2052' '2053' '2054' '2055'\
        '2056' '2057' '2058' '2059' '2060' '2061' '2062' '2063' '2064' '2065'\
        '2066' '2067' '2068' '2069' '2070' '2071' '2072' '2073' '2074' '2075'\
        '2076' '2077' '2078' '2079' '2080' '2081' '2082' '2083' '2084' '2085'\
        '2086' '2087' '2088' '2089' '2090' '2091' '2092' '2093' '2094' '2095'\
        '2096' '2097' '2098' '2099' '2100')

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
        
            for YEAR in "${YEARs[@]}"; do
            
                # select ecotron pixel
                cdo sellonlatbox,5.34,6.06,50.78,51.22 $VAR/${VAR}_${YEAR}*.nc $outDIR/rcp85/temp_${YEAR}.nc
        
            done
                
            # merge all extracted files
            cdo mergetime  $outDIR/rcp85/temp_*.nc $outDIR/rcp85/${VAR}_ecotron_EC-EARTH_CCLM4-8-17_3hr_rcp85.nc 
                
             # clean up 
            rm temp_*
     fi
done

