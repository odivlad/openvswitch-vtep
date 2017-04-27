.PHONY: prepare install-progs install-confs install update clean

SYSCONFIG_DIR     = etc/sysconfig/
SYSTEMD_UNITS_DIR = usr/lib/systemd/system/
SBIN_DIR          = usr/sbin/
SYSTEMD_UNITS     = $(wildcard usr/lib/systemd/system/*)
SCRIPTS           = $(wildcard usr/sbin/*)
DEFAULTS          = $(wildcard etc/sysconfig/*)

FILES = \
	$(SYSTEMD_UNITS) \
	$(DEFAULTS) \
	$(SCRIPTS)

DESTDIR_FILES := $(foreach file,$(FILES),$(DESTDIR)/$(file))

help:
	@echo "Please, specify make target: install/update/clean/etc..."

prepare:
	@echo "Preparing directories... "
	@mkdir -p $(DESTDIR)/$(SYSCONFIG_DIR)
	@mkdir -p $(DESTDIR)/$(SYSTEMD_UNITS_DIR)
	@mkdir -p $(DESTDIR)/$(SBIN_DIR)
	@echo "Success!"

install-progs:
	@echo "Installing progs..."
	install -m644 $(SYSTEMD_UNITS) $(DESTDIR)/$(SYSTEMD_UNITS_DIR)
	install -m755 $(SCRIPTS) $(DESTDIR)/$(SBIN_DIR)
	@echo "Success!"

install-confs:
	@echo "Instaling configs..."
	install -m644 $(DEFAULTS) $(DESTDIR)/$(SYSCONFIG_DIR)
	@echo "Success!"

install: install-progs install-confs
	@echo "Finished!"

update:
	@echo "Updating git and progs..."
	git pull origin HEAD
	install-progs
	@echo "Finished!"

clean:
	@echo "Cleaning files..."
	@rm -vf $(DESTDIR_FILES)
	@echo "Finished!"
