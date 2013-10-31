SHELL=/bin/bash
PACKAGE_DEF=texlive-dummy
PPA=ppa:krlmlr/ppa
RELEASE=raring

ARCHS=all
ARCH_DIRS=$(patsubst %,%.arch,$(ARCHS))

all: $(ARCH_DIRS)

%.arch: FORCE
	if [ "$(PWD)" != "$$(printf '%q' "$$(pwd)")" ]; then echo "ERROR: Please use from a dir whose path has no special characters"; exit 1; fi; \
	rm -rf $@ && \
	mkdir -p $@ && \
	cd $@ && \
	rm -f *.upload && \
	equivs-build --full ../$(PACKAGE_DEF) && \
	rm *.changes && \
	dpkg-source -x *.dsc && \
	cd $$(find * -maxdepth 0 -type d) && \
	pwd && \
	sed -i "s/unstable/$(RELEASE)/" debian/changelog && \
	debuild -S

upload:
	for d in $(ARCH_DIRS); do cd $$d; dput $(PPA) *.changes; cd ..; done

clean: FORCE
	rm -rf $(ARCH_DIRS)

FORCE:
