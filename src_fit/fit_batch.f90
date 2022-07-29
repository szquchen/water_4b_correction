program fit
use bemsa4b
implicit none

  external dgelss
  character:: symb
  character(len=100)::file1,file2,file3,file4
  real::work(2000000) 
  real::rmse
  integer::i,j,k,mm,info,rank,ntot,ncoeff
  integer::ndis,matom,xyzind,iflag
  integer::natm,npoly
  real,dimension(:,:,:),allocatable::xyz
  real,allocatable::v(:),v_out(:)
  real,allocatable::x(:),xyz_red(:,:)
  real,allocatable::Amat(:,:),b(:),s(:)
  real,allocatable::p(:),coeff(:)
  real,parameter::auang=0.5291772083d0
  real,parameter::aucm=219474.63d0

  open(14,file='FortranOutput.dat',status='unknown')
  write(14,*) 'reading input'

!!!!!! READ INPUT !!!!!!!!!!!!!!!!
  open (71,FILE='input_batch')
  read (71,*)
  read (71,*) file1
  read (71,*)
  read (71,*)
  read (71,*) file2
  read (71,*)
  read (71,*)
  read (71,*) file3
  read (71,*)
  read (71,*)
  read (71,*) file4
  read (71,*)
  read (71,*)
  read (71,*) natm
  read (71,*)
  read (71,*)
  read (71,*) ncoeff
  read (71,*)
  read (71,*)
  read (71,*) ntot
  read (71,*)
  read (71,*)
  read (71,*) ndis
  close (71)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  npoly=ncoeff
  write(14,*) 'input has been read, ntot = ',ntot,' npoly = ',npoly
  write(14,*) 'opening files'
  open(10,file=file1,status="old")
  open(11,file=file2,status='unknown')
  open(12,FILE=file3,status='unknown')
  open(13,file=file4,status='unknown')
 
  write(14,*) 'allocating space'
  allocate(xyz(ntot,natm,3),xyz_red(natm,3))
  allocate(v(ntot),v_out(ntot),coeff(ncoeff),s(ncoeff))

  allocate(x(1:ndis))
  allocate(Amat(ntot,ncoeff),b(ntot))
  allocate(p(1:npoly))
  write (14,*) 'allocation done, loading the data base'

! set the value of the range parameter
  call init_a(1.5)

! Feed in the database
  do i=1,ntot
     read(10,*)
     read(10,*) v(i)
     do j=1,natm
       read(10,*) symb,xyz(i,j,:)
     end do
  end do

! Transform coordinates from Angstrom to Bohr
  xyz = xyz / auang
 
  write(14,*) 'preparing for fitting'
! Prepare for fitting 
  do mm=1,ntot
     xyz_red(:,:) = xyz(mm,:,:)

! Get x's, m's, and p's
     call get_x(xyz_red,x)  ! Get Morse varaiables from Cartesian
     call bemsav(x,p)       ! calculate the permutationally-invariant poly

     Amat(mm, 1:ncoeff) = p(:)
     b(mm) = v(mm)
  enddo

  write (14,*) 'Data loaded. Start fitting'
  write (14,*) 'ntot = ',ntot
  write (14,*) 'ncoeff = ',ncoeff
  write (14,*) 'rank = ',rank

!!!!!!!!!!!!!!!!!! PERFORM THE FITTING !!!!!!!!!!!!!!!!!!
  call dgelss(ntot,ncoeff,1,Amat,ntot,b,ntot,s,1.0d-11,rank,work,2000000,info)
  write(14,*) 'info = ', info
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  write (14,*) 'fitting end.'

! Write out coefficients
  coeff(:)=b(1:ncoeff)
  do i=1,ncoeff
     write(11,*) coeff(i)
  end do

! Calculate rms on energies !!!!!!!
  write(12,"(A)") "#   V_ai (hartree)     V_PES (hartree)     Diff. (cm-1)"
  rmse=0.d0
  do mm=1,ntot
    xyz_red(:,:) = xyz(mm,:,:)
    call get_x(xyz_red,x)
    v_out (mm) = emsav (x,coeff) 
    write (12,'(2F15.8,F12.2)') v(mm),v_out(mm),(v(mm)-v_out(mm))*aucm
    rmse=rmse+(v(mm)-v_out(mm))**2
  end do
  rmse=sqrt(rmse/dble(ntot))
  write(14,"(A,F9.2,A)") 'Overall RMSE for E:', rmse*aucm, ' cm-1'
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

! Calculate rms on gradient !!!!!!!
  close (10)
  close (11)
  close (12)
  close (13)
  close (14)

end program
