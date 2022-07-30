This folder contains the code to compute the corrections.

### bemsa4b.f90
The Fortran code "bemsa4b.f90" mainly contains the subroutines to calculate the permutationally-invariant polynomials and their derivatives with respect to Cartesian coordinates.

### pes_shell.f90
The user-interface to call the PES. It has three subroutines:

(1) **pes_init**: reads in the coef_grp200_diff and initializes the PES;

(2) **correction_4b_E**: computes the correction of energy given the Cartesian coordinates of a water tetramer. The atoms must be in the order H H H H H H H H O O O O; the first 2 H and the first O come from the same monomer, the next 2 H and the next O come from another monomer, etc.

(3) **correction_4b_EG**: computes the corrections in energy and gradients at the same time, given the Cartesian coordinates of a tetramer.

### getpot.f90
An example program that shows how to call the correction PES.

### Running the program
Use the Makefile to compile the code (change the compiler and flags if needed), and then

./getpot.x 
