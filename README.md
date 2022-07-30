# 4-body Correction to the MB-pol water potential

This is a potential energy surface (PES) that corrects the 4-body component of the MB-pol water potential [1-3]. Note that the MB-pol can be downloaded at https://github.com/paesanilab/MBX; our PES only calculates the correction.

A brief description for each folder is given below; more details can be found in README files inside the folder.

## src_fit folder
This folder contains the data set used for this potential and the program that performs the potential fitting.

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
