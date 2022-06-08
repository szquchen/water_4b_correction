This is a potential energy surface (PES) that corrects the 4-body interaction in MB-pol [1-3].

Two subroutines are provided in pes_shell.f90: correction_4b_E, and correction_4b_EG; the former calculates the energy correction to MB-pol 4-b, and the latter calculates the correction for energy and gradient at the same time. The input for both subroutine is the Cartesian coordinate of a water tetramer, in bohr. The atoms must be in order H H H H H H H H O O O O.

An example to use the PES is provided in getpot.f90.

Reference:
[1] V. Babin, C. Leforestier, F. Paesani, J. Chem. Theory Comput. 9, 5395 (2013).
[2] V. Babin, G.R. Medders, F. Paesani, J. Chem. Theory Comput. 10, 1599 (2014).
[3] G.R. Medders, V. Babin, F. Paesani, J. Chem. Theory Comput. 10, 2906 (2014).
