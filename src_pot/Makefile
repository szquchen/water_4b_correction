FC := ifort
FFLAGS := -r8 -O3

OBJ := \
bemsa4b.o  pes_shell.o  getpot.o

# Targets:
.PHONY : clean 

%.o : %.f90
	$(FC) -c $(FFLAGS) $< 

getpot.x :  $(OBJ)
	$(FC) -o $@  $^ $(FFLAGS) $(LIBS)

clean :
	rm *.o *.mod 
