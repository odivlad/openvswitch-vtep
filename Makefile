.PHONY: install

SYSCONFIG_DIR     = "etc/sysconfig/"
SYSTEMD_UNITS_DIR = "usr/lib/systemd/system/"
SBIN_DIR          = "usr/sbin/"

install:
	@echo -n "Installing files... "
	@mkdir -p $(DESTDIR)/$(SYSCONFIG_DIR)
	@mkdir -p $(DESTDIR)/$(SYSTEMD_UNITS_DIR)
	@mkdir -p $(DESTDIR)/$(SBIN_DIR)
	@cp -at $(DESTDIR)/$(SYSCONFIG_DIR) $(SYSCONFIG_DIR)/*
	@cp -at $(DESTDIR)/$(SYSTEMD_UNITS_DIR) $(SYSTEMD_UNITS_DIR)/*
	@cp -at $(DESTDIR)/$(SBIN_DIR) $(SBIN_DIR)/*
	@echo "Finished!"
