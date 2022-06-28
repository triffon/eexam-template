OUTDIR := out

define instantiate_targets

all${1}:	inf${1} is${1} cs${1} se${1}

cs${1}:		$(OUTDIR)/eexam_computer_science${1}.pdf

inf${1}:	$(OUTDIR)/eexam_informatics${1}.pdf

is${1}:		$(OUTDIR)/eexam_information_systems${1}.pdf

se${1}:		$(OUTDIR)/eexam_software_engineering${1}.pdf

endef

$(eval $(call instantiate_targets,))
$(eval $(call instantiate_targets,_solutions))

$(OUTDIR)/%.pdf:	%.tex FORCE_MAKE
	latexmk $<

$(OUTDIR)/%_solutions.pdf:	%.tex FORCE_MAKE
	latexmk -usepretex='\def\fmisolutions{}' -jobname=$*_solutions $<

clean:
	rm -rf $(OUTDIR)

.PHONY:	all clean FORCE_MAKE gdrive

# include gdrive helper targets
include eexam/Makefile.gdrive
