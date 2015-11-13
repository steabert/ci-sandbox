# ifort
#------
#FC = ifort
#FFLAGS = -fpp -debug -check bounds -warn
#LDFLAGS = -mkl

# gfortran
#---------
FC = gfortran
FFLAGS = -cpp
LDFLAGS = -llapack -lblas

SRC = caspt2_mini.f90 caspt2_axb.f90 caspt2_udl.f90 fullci.f90 second_quantization.f90 wavefunction.f90 density.f90 fockmatrix.f90 orbint.f90
OBJ = $(SRC:.f90=.o)
MOD = second_quantization.mod wavefunction.mod density.mod fockmatrix.mod orbint.mod
EXE = caspt2_mini.exe

# named targets
all: $(EXE)

# ifort
#------
#debug: FFLAGS += -debug -check bounds -warn all 

# gfortran
#---------
debug: FFLAGS += -O0 -ggdb -fbounds-check -fsanitize=address -fno-omit-frame-pointer -Wall

debug: all

fast: FFLAGS += -fast
fast: all

clean:
	$(RM) $(OBJ) $(MOD) $(EXE)

# target dependencies

caspt2_mini.f90: $(MOD)

$(EXE): $(OBJ) $(MOD)
	$(FC) $(FFLAGS) -o $@ $(OBJ) $(LDFLAGS)

# implicit rules
%.o %.mod: %.f90
	$(FC) $(FFLAGS) -c $<
