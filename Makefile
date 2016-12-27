.PHONY: install

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


install:
	@echo -n "Installing files... "
	@mkdir -p $(DESTDIR)/$(SYSCONFIG_DIR)
	@mkdir -p $(DESTDIR)/$(SYSTEMD_UNITS_DIR)
	@mkdir -p $(DESTDIR)/$(SBIN_DIR)
	install -m644 $(SYSTEMD_UNITS) $(DESTDIR)/$(SYSTEMD_UNITS_DIR)
	install -m755 $(SCRIPTS) $(DESTDIR)/$(SBIN_DIR)
	install -m644 $(DEFAULTS) $(DESTDIR)/$(SYSCONFIG_DIR)
	@echo "Finished!"


clean:
	@echo -n "Cleaning files... $(DESTDIR_FILES)"
	@rm -f $(DESTDIR_FILES)
	@echo "Finished!"
