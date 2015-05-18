VDIR:=$(shell pwd)/fc_env

install: install-DAZZ_DB install-DALIGNER install-pypeFLOW install-FALCON
install-DAZZ_DB:
	cd DAZZ_DB; make; ln -sf $$PWD/DBrm $$PWD/DBshow $$PWD/DBsplit $$PWD/DBstats $$PWD/fasta2DB ${VDIR}/bin/
install-DALIGNER:
	cd DALIGNER; make; ln -sf $$PWD/daligner $$PWD/daligner_p $$PWD/DB2Falcon $$PWD/HPCdaligner $$PWD/LA4Falcon $$PWD/LAmerge $$PWD/LAsort  ${VDIR}/bin
install-pypeFLOW:
	cd pypeFLOW; . ${VDIR}/bin/activate; python setup.py install
install-FALCON:
	. ${VDIR}/bin/activate; python setup.py install
pre:
	git submodule init
	git submodule update
virtualenv:
	mkdir -p ${VDIR}
	virtualenv -p $(shell which python2.7) --no-site-packages  --always-copy ${VDIR}
	# Or add -p PATH_TO_PYTHON
check:
	. ${VDIR}/bin/activate; which python
clean:
	cd DAZZ_DB; make clean
	cd DALIGNER; make clean
