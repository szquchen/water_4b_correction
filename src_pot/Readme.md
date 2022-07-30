This folder contains the code to compute the corrections.

The code "bemsa4b.f90" are the same as the one in the src_fit folder; it contains subroutines that computes the polynomials and derivatives.

The code "pes_shell.f90" is the user interface. It has three subroutines: pes_init() reads in the coefficients and initializes the PES; correction_4b_E() computes the correction of energies given the Cartesian coordinates of a water tetramer; correction_4b_EG() computes the correction of energies and gradients given the Cartesian coordinates

getpot.f90 is the main program; it shows how to call this correction PES.
