INST_KEYRINGS =
INST_KEYS =
dist_noinst_DATA =

MASTER_KEYRING = eos-master-keyring.gpg
MASTER_KEYS = \
	keys/master/MK1.pub \
	keys/master/MK2.pub \
	$(NULL)
$(MASTER_KEYRING): $(MASTER_KEYS)
INST_KEYRINGS += $(MASTER_KEYRING)
INST_KEYS += $(MASTER_KEYS)

OSTREE_KEYRING = eos-ostree-keyring.gpg
OSTREE_KEYS = \
	keys/signing/EOSK1.pub \
	$(NULL)
$(OSTREE_KEYRING): $(OSTREE_KEYS)
INST_KEYRINGS += $(OSTREE_KEYRING)
INST_KEYS += $(OSTREE_KEYS)

FLATPAK_KEYRING = eos-flatpak-keyring.gpg
FLATPAK_KEYS = \
	keys/signing/EFSK1.pub \
	$(NULL)
$(FLATPAK_KEYRING): $(FLATPAK_KEYS)
INST_KEYRINGS += $(FLATPAK_KEYRING)
INST_KEYS += $(FLATPAK_KEYS)

IMAGE_KEYRING = eos-image-keyring.gpg
IMAGE_KEYS = \
	keys/signing/EIS1.pub \
	$(NULL)
$(IMAGE_KEYRING): $(IMAGE_KEYS)
INST_KEYRINGS += $(IMAGE_KEYRING)
INST_KEYS += $(IMAGE_KEYS)

ARCHIVE_KEYRING = eos-archive-keyring.gpg
ARCHIVE_KEYS = \
	keys/signing/EASK1.pub \
	$(NULL)
$(ARCHIVE_KEYRING): $(ARCHIVE_KEYS)
INST_KEYRINGS += $(ARCHIVE_KEYRING)
INST_KEYS += $(ARCHIVE_KEYS)

CODECS_KEYRING = eos-codecs-keyring.gpg
CODECS_KEYS = \
	keys/codecs/ECMK1.pub \
	keys/codecs/ECAK1.pub \
	keys/codecs/ECOAK1.pub \
	keys/codecs/ECUAK1.pub \
	keys/codecs/ECFAK1.pub \
	keys/codecs/ECHNDAK1.pub \
	keys/codecs/ECSOLAK1.pub \
	keys/codecs/ECHKAK1.pub \
	$(NULL)
$(CODECS_KEYRING): $(CODECS_KEYS)
INST_KEYRINGS += $(CODECS_KEYRING)
INST_KEYS += $(CODECS_KEYS)

# Debian archive keyring for Endless infrastructure packages
# http://obs-master.endlessm-sf.com:82/shared/infra/
INFRA_KEYRING = eos-infra-archive-keyring.gpg
INFRA_KEYS = \
	keys/signing/EIASK1.pub \
	$(NULL)
$(INFRA_KEYRING): $(INFRA_KEYS)
INST_KEYRINGS += $(INFRA_KEYRING)
INST_KEYS += $(INFRA_KEYS)

# Endless public archive keyring for https://sources.endlessm.com/debian/
PUBARCHIVE_KEYRING = eos-pub-archive-keyring.gpg
PUBARCHIVE_KEYS = \
	keys/signing/EPASK1.pub \
	$(NULL)
$(PUBARCHIVE_KEYRING): $(PUBARCHIVE_KEYS)
INST_KEYRINGS += $(PUBARCHIVE_KEYRING)
INST_KEYS += $(PUBARCHIVE_KEYS)

# GPG keyring just for testing
NOINST_KEYRING = noinst-keyring.gpg
NOINST_KEYS = \
	keys/signing/ESBASK1.pub \
	$(NULL)
$(NOINST_KEYRING): $(NOINST_KEYS)
noinst_DATA = $(NOINST_KEYRING)

ALL_KEYRINGS = $(INST_KEYRINGS) $(NOINST_KEYRING)
ALL_KEYS = $(INST_KEYS) $(NOINST_KEYS)

EXTRA_DIST = $(ALL_KEYS)

keyringdir = $(datadir)/keyrings
keyring_DATA = $(INST_KEYRINGS)

ostree_keyringdir = $(datadir)/ostree/trusted.gpg.d
ostree_keyring_DATA = $(OSTREE_KEYRING) $(FLATPAK_KEYRING)

archive_keyringdir = $(sysconfdir)/apt/trusted.gpg.d
archive_keyring_DATA = $(ARCHIVE_KEYRING) $(INFRA_KEYRING)

$(ALL_KEYRINGS):
	$(AM_V_GEN)GPG='$(GPG)' $(srcdir)/build-keyring $@ $^

# X.509 certificates
ALL_X509_CERTS =

# Endless CA certificate for internal services
# https://phabricator.endlessm.com/w/sysadmin/ssl-ca/
#
# Install a copy in both $(pkgdatadir) and $(datadir)/ca-certificates.
# It would be nice if the one in ca-certificates could be a symlink, but
# ca-certificates doesn't support that.
ENDLESS_CA_CERT = keys/tls/endless-ca.crt
ALL_X509_CERTS += $(ENDLESS_CA_CERT)
cacertsdir = $(datadir)/ca-certificates/endless
dist_pkgdata_DATA = $(ENDLESS_CA_CERT)
dist_cacerts_DATA = $(ENDLESS_CA_CERT)
dist_bin_SCRIPTS = \
	scripts/endless-ca-trust-system \
	scripts/endless-ca-trust-user \
	$(NULL)
profiledir = $(sysconfdir)/profile.d
dist_profile_DATA = profile/endless-ca-trust-user.sh

# Endless UEFI secure boot CA certificate
# https://phabricator.endlessm.com/w/software/secure_boot/
ENDLESS_EFI_CA_CERT = keys/efi/Endless-Secure-Boot-CA.crt
ALL_X509_CERTS += $(ENDLESS_EFI_CA_CERT)
dist_noinst_DATA += $(ENDLESS_EFI_CA_CERT)

# Configuration for test scripts
TEST_CONFIG = test-config.sh
check_DATA = $(TEST_CONFIG)
dist_noinst_DATA += $(TEST_CONFIG).in
subst_test_config = sed \
	-e 's,%srcdir%,$(srcdir),' \
	-e 's,%abs_srcdir%,$(abs_srcdir),' \
	-e 's,%builddir%,$(builddir),' \
	-e 's,%abs_builddir%,$(abs_builddir),' \
	-e 's,%GPG%,$(GPG),' \
	-e 's,%OPENSSL%,$(OPENSSL),' \
	-e 's,%ALL_KEYRINGS%,$(ALL_KEYRINGS),' \
	-e 's,%ALL_KEYS%,$(ALL_KEYS),' \
	-e 's,%ALL_X509_CERTS%,$(ALL_X509_CERTS),' \
	$(NULL)
$(TEST_CONFIG): $(TEST_CONFIG).in Makefile
	$(AM_V_GEN)$(subst_test_config) $< > $@.tmp && mv -f $@.tmp $@

CLEANFILES = $(ALL_KEYRINGS) $(TEST_CONFIG)
clean-local:
	rm -f *.gpg~ *.gpg.tmp *.gpg.tmp~ $(TEST_CONFIG).tmp
	rm -rf gnupg

# Build scripts
dist_noinst_SCRIPTS = \
	build-keyring \
	$(NULL)

# Test scripts
dist_check_SCRIPTS = \
	test-expiration \
	test-import \
	test-x509-expiration \
	$(NULL)

TESTS = $(dist_check_SCRIPTS)

# Set path to test-config.sh so test scripts can find it
AM_TESTS_ENVIRONMENT = TEST_CONFIG='$(abs_builddir)/$(TEST_CONFIG)'

# Configure tests to use TAP protocol
LOG_DRIVER = env AM_TAP_AWK='$(AWK)' $(SHELL) $(top_srcdir)/tap-driver.sh
