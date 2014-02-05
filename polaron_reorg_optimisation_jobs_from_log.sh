#Jarv ~ 26-4-12
# 5-2-14, adapt for .log files
#Generate .com files from a base .log file for the necessary jobs to calc polaron reorg energy

CHARGE="-1" # -1 = Anion (i.e. electron acceptor, such as a fullerene)
 # +1 = Cation (i.e. electron donor, such as P3HT oligomer)

for i
do
#OK; Need: Geom opts in the neutral and charged state
#SP energy calcs for each of these in n + c state

cat > "${i%.*}_ion_opt.com" << EOF
%chk=${i%.*}_ion_opt.chk
%Mem=8Gb
%nproc=8
#p opt b3lyp/6-31g*

B3lyp auto opt job - neutral state

${CHARGE} 2
EOF

jkp_extract_geom.awk "${i}" >>  "${i%.*}_ion_opt.com"
echo >>  "${i%.*}_ion_opt.com"

cat > "${i%.*}_neutral_opt.com" << EOF
%chk=${i%.*}_neutral_opt.chk
%Mem=8Gb
%nproc=8
#p opt b3lyp/6-31g*

B3lyp auto opt job - neutral state

0 1
EOF

jkp_extract_geom.awk "${i}" >> "${i%.*}_neutral_opt.com"
echo >> "${i%.*}_neutral_opt.com"

done
