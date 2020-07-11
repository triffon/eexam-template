OUTDIR := out

all:	inf is cs se

cs:	$(OUTDIR)/eexam_computer_science.pdf

inf:	$(OUTDIR)/eexam_informatics.pdf

is:	$(OUTDIR)/eexam_information_systems.pdf

se:	$(OUTDIR)/eexam_software_engineering.pdf

$(OUTDIR)/%.pdf:	%.tex FORCE_MAKE
	latexmk $<

clean:
	rm -rf $(OUTDIR)

.PHONY:	all clean FORCE_MAKE gdrive

# include gdrive helper targets
include eexam/Makefile.gdrive
