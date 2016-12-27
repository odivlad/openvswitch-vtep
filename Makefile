.PHONY: install

SYSTEMD_UNITS_DIR = "usr/lib/systemd/system/"
SYSCONFIG_DIR     = "etc/sysconfig/"

install:
	@echo -n "Installing files... "
	@mkdir -p $(DESTDIR)/$(SYSTEMD_UNITS_DIR)
	@mkdir -p $(DESTDIR)/$(SYSCONFIG_DIR)
	@cp -at $(DESTDIR)/$(SYSTEMD_UNITS_DIR) $(SYSTEMD_UNITS_DIR)
	@cp -at $(DESTDIR)/$(SYSCONFIG_DIR) $(SYSCONFIG_DIR)
	@echo "Finished!"
