PACKAGE_DEF=texlive-dummy
PPA=ppa:krlmlr/ppa

ARCHS=all
ARCH_DIRS=$(patsubst %,%.arch,$(ARCHS))

all: $(ARCH_DIRS)

%.arch: FORCE
	if [ "$(PWD)" != "$(firstword $(PWD))" ]; then echo "ERROR: Please use from within a directory that does not contain spaces"; exit 1; fi; \
	rm -rf $@ && \
	mkdir -p $@ && \
	cd $@ && \
	rm -f *.upload && \
	equivs-build --full ../$(PACKAGE_DEF) && \
	rm *.changes && \
	dpkg-source -x *.dsc && \
	cd $$(find * -maxdepth 0 -type d) && \
	pwd && \
	sed -i 's/unstable/raring/' debian/changelog && \
	debuild -S

upload:
	for d in $(ARCH_DIRS); do cd $$d; dput $(PPA) *.changes; cd ..; done

clean: FORCE
	rm -rf $(ARCH_DIRS)

FORCE:
