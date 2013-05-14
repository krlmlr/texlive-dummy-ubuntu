PACKAGE_DEF=texlive-dummy
PPA=ppa:mail-kirill-mueller/ppa

ARCHS=amd64 i386
ARCH_DIRS=$(patsubst %,%.arch,$(ARCHS))

all: $(ARCH_DIRS)

%.arch: FORCE
	mkdir -p $@ && cd $@ && equivs-build --full --arch $* ../$(PACKAGE_DEF)

upload:
	for d in $(ARCH_DIRS); do cd $$d; dput $(PPA) *.changes; cd ..; done

clean: FORCE
	rm -rf $(ARCH_DIRS)

FORCE:
