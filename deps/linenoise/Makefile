STD=
WARN= -Wall
OPT= -Os -fno-common -ftls-model=initial-exec -ffunction-sections -fdata-sections
CC:=/usr/local/popcorn/bin/popcorn-clang-no-mig
CC=/usr/local/popcorn/bin/popcorn-clang-no-mig

R_CFLAGS= $(STD) $(WARN) $(OPT) $(DEBUG) $(CFLAGS)
R_LDFLAGS= $(LDFLAGS)
DEBUG= -g

R_CC=$(CC) $(R_CFLAGS)
R_LD=$(CC) $(R_LDFLAGS)

linenoise.o: linenoise.h linenoise.c

linenoise_example: linenoise.o example.o
	$(R_LD) -o $@ $^

.c.o:
	$(R_CC) -c $<

clean:
	rm -f linenoise_example *.o
