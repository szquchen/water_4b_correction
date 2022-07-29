module pes_shell
  use bemsa4b
  implicit none

  real::coef(200)
  real,parameter::nmono = 1438

  ! Define the mass of different atoms
  real,parameter::c_mass= 12.0000000  !21874.66
  real,parameter::h_mass=  1.0078250  !1837.15
  real,parameter::d_mass=  2.0141018  !D
  real,parameter::o_mass= 15.9949146  !29156.95
  real,parameter::n_mass= 14.003074
  real,parameter::pi=acos(-1.0)

  ! Define constants
  real,parameter::emass=1822.88848
  real,parameter::auang=0.5291772083
  real,parameter::aucm=219474.6313710
  real,parameter::aukcal=627.51        ! energy: unit (kacl/mol)/au   
  real,parameter::aufs=2.4188843265e-2 ! time  : unit femi_second / au

contains
  !==========================!
  ! read in the coefficients !
  !==========================!
  subroutine pes_init()
    character(len=90)::path
    integer::i,ncoef

    path = "../coef/coeff_grp200_diff"
    open(20,file=trim(path),status="old")
  
    ncoef = size(coef)
    do i=1,ncoef
       read(20,*) coef(i)
    end do

    call init_a(1.5)

    close(20)
    return
  end subroutine

  !===================================================!
  ! calculate the 4-b correction energy               !
  !   x(12,3): coordinates in bohr, the atoms must be !
  !            in the order H H H H H H H H O O O O   !
  !===================================================!
  subroutine correction_4b_E(x, delta_E_4b)
    real,dimension(:,:),intent(in)::x
    real,intent(out)::delta_E_4b
    !:::::::::::::::::::::::::
    real,dimension(66)::morse

    call get_x(x, morse)
    delta_E_4b = emsav(morse, coef)

    return
  end subroutine

  !===================================================!
  ! Calculate E and g from the correction PES         !
  !   x(12,3): coordinates in bohr, the atoms must be !
  !             in the order H H H H H H H H O O O O  !
  !===================================================!
  subroutine correction_4b_EG(x, delta_E_4b, delta_G_4b)
    real,dimension(:,:),intent(in)::x
    real,dimension(:),intent(out)::delta_G_4b
    real,intent(out)::delta_E_4b
    !:::::::::::::::::::::::::
    real,dimension(66)::morse
    real::m(1:nmono),p(1:size(coef))

    call get_x(x, morse)
    call evmono(morse, m)
    call evpoly(m, p)

    delta_E_4b = dot_product(p, coef)
    call derivative_reverse(coef, m, p, x, delta_G_4b)

    return
  end subroutine

end module
