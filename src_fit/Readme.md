This folder contains the code to fit the correction potential and to generate "coeff_grp200_diff".

The dataset used for the fitting is "4b_diff_3692.xyz", which is the difference between the CCSD(T)-F12 energy and the MB-pol ones. (For reference, "4b_ccsd_3692.xyz", which contains the original CCSD(T)-F12 energies, is also included in this folder).

The Fortran code "bemsa4b.f90" contains the subroutines to calculate the permutationally-invariant polynomials and their derivatives with respect to Cartesian coordinates.

The Fortran code "fit_batch.f90" performs the fitting, using DGELSS from LAPACK
