This folder contains the dataset and the program to fit the correction potential and to generate "coeff_grp200_diff".

### Dataset
The dataset used for the fitting is "4b_diff_3692.xyz", which is the difference between the CCSD(T)-F12 energy and the MB-pol ones. (For reference, "4b_ccsd_3692.xyz", which contains the original CCSD(T)-F12 energies, is also included in this folder).

These files are in the standard xyz format: for each molecular configuration, the first line is the number of atoms; the second line is the energy (CCSD(T) or difference) in hartree; the remaining 12 lines are the Cartesian coordinates of each atom in Angstrom. The first 2 H and the first O are from monomer 1, the following 2 H and the second O are from monomer 2, etc. The monomer as a whole is interchangable, but H and O from different monomers should not be mixed.

### bemsa4b.f90
The Fortran code "bemsa4b.f90" mainly contains the subroutines to calculate the permutationally-invariant polynomials (p) and their derivatives with respect to Cartesian coordinates.


The Fortran code "fit_batch.f90" performs the fitting, using DGELSS from LAPACK
