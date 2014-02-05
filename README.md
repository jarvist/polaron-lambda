Scripts to generate the 4-Gaussian jobs from an input molecule to calculate the
'inner sphere' reorganisation energy.

This is useful as an input into the Marcus equation for electron / hole
transport in organic semiconducting materials.

These calculations are pretty trivial and can be created by hand, but I wrote
these scripts to allow the automatic calculation of many lambdas of different fullerenes / oligomers (in
particular, when seeing whether you could vary lambda by chemical design to
induce better charge transport).

The scripts are very hairy.

# Using these Scripts

0. Start with either Gaussian Checkpoints (.chk) or Log Files (.log) of the structures you want to calculate the inner-sphere reorganisation of.

1. Run ./polaron_reorg_optimisation_jobs_from_chk.sh or ./polaron_reorg_optimisation_jobs_from_log.sh

````
    >ls
    mylovelymolecule.chk 
    >./polaron_reorg_optimisation_jobs_from_chk.sh *.chk
    >ls
    mylovelymolecule.chk mylovelymolecule_ion_opt.chk mylovelymolecule_ion_opt.com mylovelymolecule_neutral_opt.chk mylovelymolecule_neutral_opt.com 
````

2. Run these jobs, retaining the checkpoints.

3. Generate the energy jobs (Nb: you could use a different / higher level of theory here)
````
    >./polaron_reorg_energy_jobs_from_geom_chks.sh *_opt.chk
````
4. Run these *_E.com jobs...

5. Have a tasty look at the reorganisation energies with the handy ./calc_reorg_energy.sh script
````
    >./calc_reorg_energy.sh mylovelymolecule
    C60_b3lypopt
    N_ion:  -2286.24731990 N_neu:  -2286.17409196 I_ion:  -2286.24982989 I_neu:  -2286.17154854
    Neutral transition (I_new-N_neu) in eV: .06920900162
    Ion transition (N_ion - I_ion) in eV: .06829933789
    .13750833951
````
6. C60 has an inner sphere reorganisation energy of 138 meV at b3lyp/6-31g*.
