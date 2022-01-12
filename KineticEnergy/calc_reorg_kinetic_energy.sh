for i
do
    echo "${i} (Hartree unless specified)"
    N_ion=` grep "SCF Done" "${i}"*neutral_opt_ion_E.log | awk '{print $5}' `

# Looks like
#  KE= 2.264715628044E+03 PE=-2.193185585439E+04 EE= 9.060477763550E+03
#     Are these units definite Hartree? - JMF
    N_ion_KE=`  grep ^\ KE= "${i}"*neutral_opt_ion_E.log | sed s/D/E/g | awk '{printf("%.4f\n",$2)}' `
    N_ion_PE=`  grep ^\ KE= "${i}"*neutral_opt_ion_E.log | sed -e s/D/E/g -e s/=/\ /g | awk '{printf("%.4f\n",$4)}' `
    N_ion_EE=`  grep ^\ KE= "${i}"*neutral_opt_ion_E.log | sed -e s/D/E/g -e s/=/\ /g | awk '{printf("%.4f\n",$6)}' `


    N_neu=` grep "SCF Done" "${i}"*neutral_opt_neutral_E.log |  awk '{print $5}' `
    N_neu_KE=`  grep ^\ KE= "${i}"*neutral_opt_neutral_E.log | sed s/D/E/g | awk '{printf("%.4f\n",$2)}' `
    N_neu_PE=`  grep ^\ KE= "${i}"*neutral_opt_neutral_E.log | sed -e s/D/E/g -e s/=/\ /g | awk '{printf("%.4f\n",$4)}' `
    N_neu_EE=`  grep ^\ KE= "${i}"*neutral_opt_neutral_E.log | sed -e s/D/E/g -e s/=/\ /g | awk '{printf("%.4f\n",$6)}' `


    I_ion=` grep "SCF Done" "${i}"*ion_opt_ion_E.log | awk '{print $5}' `
    I_ion_KE=`  grep ^\ KE= "${i}"*ion_opt_ion_E.log | sed s/D/E/g | awk '{printf("%.4f\n",$2)}' `
    I_ion_PE=`  grep ^\ KE= "${i}"*ion_opt_ion_E.log | sed -e s/D/E/g -e s/=/\ /g | awk '{printf("%.4f\n",$4)}' `
    I_ion_EE=`  grep ^\ KE= "${i}"*ion_opt_ion_E.log | sed -e s/D/E/g -e s/=/\ /g | awk '{printf("%.4f\n",$6)}' `


    I_neu=` grep "SCF Done" "${i}"*ion_opt_neutral_E.log | awk '{print $5}' `
    I_neu_KE=`  grep ^\ KE= "${i}"*ion_opt_neutral_E.log | sed s/D/E/g | awk '{printf("%.4f\n",$2)}' `
    I_neu_PE=`  grep ^\ KE= "${i}"*ion_opt_neutral_E.log | sed -e s/D/E/g -e s/=/\ /g | awk '{printf("%.4f\n",$4)}' `
    I_neu_EE=`  grep ^\ KE= "${i}"*ion_opt_neutral_E.log | sed -e s/D/E/g -e s/=/\ /g | awk '{printf("%.4f\n",$6)}' `


 echo "N_ion: " $N_ion "N_neu: " $N_neu "I_ion: " $I_ion "I_neu: " $I_neu
 echo "N_ion_KE: " $N_ion_KE "N_neu_KE: " $N_neu_KE "I_ion_KE: " $I_ion_KE "I_neu_KE: " $I_neu_KE
 echo "N_ion_PE: " $N_ion_PE "N_neu_PE: " $N_neu_PE "I_ion_PE: " $I_ion_PE "I_neu_PE: " $I_neu_PE

 echo -n "Kinetic energy change, charging in Neutral geometry (eV): "
 echo $N_ion_KE $N_neu_KE | awk '{print(($1-$2)*27.211)}'

 echo -n "Kinetic energy change, charging in Ion geometry (eV): "
 echo $I_ion_KE $I_neu_KE | awk '{print (($1-$2)*27.211)}'

 echo -n "Kinetic energy change on polaron formation (Kinetic energy change of the ion, during neutral->ion geometry) (eV): "
 echo $N_ion_KE $I_ion_KE | awk '{print (($1-$2)*27.211)}'
 echo -n "Potential energy change on polaron formation (Potential energy change of the ion, during neutral->ion geometry) (eV): "
 echo $N_ion_PE $I_ion_PE | awk '{print (($1-$2)*27.211)}'
 echo -n "Electron repulsion energy change on polaron formation (Potential energy change of the ion, during neutral->ion geometry) (eV): "
 echo $N_ion_EE $I_ion_EE | awk '{print (($1-$2)*27.211)}' 
 echo -n "PE + 2*EE (eV) "
 echo $N_ion_PE $I_ion_PE $N_ion_EE $I_ion_EE | awk '{print ((($1-$2)+2*($3-$4))*27.211)}' 
 

 echo -n "Overall energy change on polaron formation (eV):"
 echo $N_ion $I_ion | awk '{print (($1-$2)*27.211)}'
 


 echo -n "Lambda from Neutral transition (I_new-N_neu) in eV: " 
 echo "($I_neu - $N_neu) * 27.211 " | bc -l

 echo -n "Lambda from Ion transition (N_ion - I_ion) in eV: "
 echo "($N_ion - $I_ion) * 27.211 " | bc -l

 echo "Total Lambda inner-sphere reorg energy (eV): "
# 'we follow the method of Sakanou' - JKP Thesis 2.2 Reorganisation Energy
 echo "(($I_neu - $N_neu) + ($N_ion - $I_ion) ) * 27.211 " | bc -l
echo

done
