# 4-body Correction to the MB-pol water potential

This is a potential energy surface (PES) that corrects the 4-body component of the MB-pol water potential [1-3]. A brief description for each folder is given below; more details can be found in README files inside the folder.

## src_fit folder
This folder contains the program that performs the potential fitting.

The dataset used for the fitting is "4b_diff_3692.xyz", which is the difference between the CCSD(T)-F12 energy and the MB-pol ones. (For reference, "4b_ccsd_3692.xyz", which contains the original CCSD(T)-F12 energies, is also included in this folder).

The Fortran code "bemsa4b.f90" contains the subroutines to calculate the permutationally-invariant polynomials and their derivatives with respect to Cartesian coordinates.

The Fortran code "fit_batch.f90" performs the fitting, using DGELSS from LAPACK

## coef folder
The linear coefficients obtained from the fit are inside this folder

## src_pot folder
This folder contains the code to compute the corrections.

The code "bemsa4b.f90" are the same as the one in the src_fit folder; it contains subroutines that computes the polynomials and derivatives.

The code "pes_shell.f90" is the user interface. It has three subroutines: pes_init() reads in the coefficients and initializes the PES; correction_4b_E() computes the correction of energies given the Cartesian coordinates of a water tetramer; correction_4b_EG() computes the correction of energies and gradients given the Cartesian coordinates

getpot.f90 is the main program; it shows how to call this correction PES.

## References

[1] V. Babin, C. Leforestier, F. Paesani, J. Chem. Theory Comput. 9, 5395 (2013).

[2] V. Babin, G.R. Medders, F. Paesani, J. Chem. Theory Comput. 10, 1599 (2014).

[3] G.R. Medders, V. Babin, F. Paesani, J. Chem. Theory Comput. 10, 2906 (2014).
