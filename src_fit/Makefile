# using ifort and MKL
FC = ifort -r8 -O
LIBS = -qmkl=sequential

%.o: %.f90
	$(FC) -c $<

OBJFIT := bemsa4b.o \
          fit_batch.o

fit_batch.x : $(OBJFIT) 
	$(FC) -o $@ $^ $(LIBS)

clean:
	rm -f *.o *.mod *.x	
