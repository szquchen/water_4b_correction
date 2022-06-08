program main
  use pes_shell
  implicit none

  real::x(12,3), delta_e, delta_g(36), e_diff
  integer::j,natm
  character::symb

  open(20,file="test_input.xyz", status="old")
  read(20,*) natm
  read(20,*) e_diff
  do j=1,natm
     read(20,*) symb, x(j,1:3)
  end do
  x = x / auang

! read in the coefs of the fit
  call pes_init()

! get the energy correction only
!  call correction_4b_E(x, delta_e)

! get the correction for both energy and gradient
  call correction_4b_EG(x, delta_e, delta_g)

  write(*,'(A,F15.8)') "Energy correction (hartree):", delta_e
  write(*,'(A)') "Gradient correction (hartree/bohr):"
  do j=1,natm*3
     write(*,'(F15.8)') delta_g(j)
  end do

end program main
