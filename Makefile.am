ALL_KEYRINGS =
ALL_KEYS =

MASTER_KEYRING = eos-master-keyring.gpg
MASTER_KEYS = \
	keys/master/MK1.pub \
	keys/master/MK2.pub \
	$(NULL)
$(MASTER_KEYRING): $(MASTER_KEYS)
ALL_KEYRINGS += $(MASTER_KEYRING)
ALL_KEYS += $(MASTER_KEYS)

APPS_KEYRING = eos-apps-keyring.gpg
APPS_COMPAT_KEYRING = eos-keyring.gpg
APPS_KEYS = \
	keys/signing/EAPPSERVERPROD1.pub \
	keys/signing/EAPPSERVERSTAG1.pub \
	$(NULL)
$(APPS_KEYRING): $(APPS_KEYS)
ALL_KEYRINGS += $(APPS_KEYRING)
ALL_KEYS += $(APPS_KEYS)

OSTREE_KEYRING = eos-ostree-keyring.gpg
OSTREE_KEYS = \
	keys/signing/ECOLSK1.pub \
	keys/signing/EOSK1.pub \
	$(NULL)
$(OSTREE_KEYRING): $(OSTREE_KEYS)
ALL_KEYRINGS += $(OSTREE_KEYRING)
ALL_KEYS += $(OSTREE_KEYS)

FLATPAK_KEYRING = eos-flatpak-keyring.gpg
FLATPAK_KEYS = \
	keys/signing/EFSK1.pub \
	$(NULL)
$(FLATPAK_KEYRING): $(FLATPAK_KEYS)
ALL_KEYRINGS += $(FLATPAK_KEYRING)
ALL_KEYS += $(FLATPAK_KEYS)

IMAGE_KEYRING = eos-image-keyring.gpg
IMAGE_KEYS = \
	keys/signing/EIS1.pub \
	$(NULL)
$(IMAGE_KEYRING): $(IMAGE_KEYS)
ALL_KEYRINGS += $(IMAGE_KEYRING)
ALL_KEYS += $(IMAGE_KEYS)

ARCHIVE_KEYRING = eos-archive-keyring.gpg
ARCHIVE_KEYS = \
	keys/signing/EASK1.pub \
	$(NULL)
$(ARCHIVE_KEYRING): $(ARCHIVE_KEYS)
ALL_KEYRINGS += $(ARCHIVE_KEYRING)
ALL_KEYS += $(ARCHIVE_KEYS)

CODECS_KEYRING = eos-codecs-keyring.gpg
CODECS_KEYS = \
	keys/codecs/ECMK1.pub \
	keys/codecs/ECAK1.pub \
	keys/codecs/ECOAK1.pub \
	keys/codecs/ECUAK1.pub \
	$(NULL)
$(CODECS_KEYRING): $(CODECS_KEYS)
ALL_KEYRINGS += $(CODECS_KEYRING)
ALL_KEYS += $(CODECS_KEYS)

EXTRA_DIST = $(ALL_KEYS)

keyringdir = $(datadir)/keyrings
keyring_DATA = $(ALL_KEYRINGS)

apps_keyringdir = $(datadir)/eos-app-manager
apps_keyring_DATA = $(APPS_KEYRING)

ostree_keyringdir = $(datadir)/ostree/trusted.gpg.d
ostree_keyring_DATA = $(OSTREE_KEYRING) $(FLATPAK_KEYRING)

archive_keyringdir = $(sysconfdir)/apt/trusted.gpg.d
archive_keyring_DATA = $(ARCHIVE_KEYRING)

$(ALL_KEYRINGS):
	$(MKDIR_P) -m700 gnupg
	keys='$^'; \
	for key in $$keys; do \
	  $(GPG) --homedir gnupg --no-default-keyring \
	    --keyring $(builddir)/$@ --import $$key || exit 1; \
	done

# Provide a compatibility symlink for eos-app-manager since it has a
# hardcoded keyring rather than a keyring directory.
install-data-hook:
	$(MKDIR_P) $(DESTDIR)$(apps_keyringdir)
	$(LN_S) -f $(APPS_KEYRING) $(DESTDIR)$(apps_keyringdir)/$(APPS_COMPAT_KEYRING)

uninstall-local:
	rm -f $(DESTDIR)$(apps_keyringdir)/$(APPS_COMPAT_KEYRING)

CLEANFILES = $(ALL_KEYRINGS)
clean-local:
	rm -f *.gpg~
	rm -rf gnupg

check-local: $(ALL_KEYRINGS)
	rm -rf gnupg
	$(MKDIR_P) -m700 gnupg
	keyrings='$^'; \
	for keyring in $$keyrings; do \
	  $(GPG) --homedir gnupg --import $$keyring || exit 1; \
	done
	fingerprints=`$(GPG) --homedir gnupg --list-keys --with-colons \
	  --with-fingerprint | grep fpr | awk -F ':' '{print $$10}'`; \
	for fpr in $$fingerprints; do \
	  echo "$$fpr:6:" | $(GPG) --homedir gnupg --import-ownertrust; \
	done
	$(GPG) --homedir gnupg --check-trustdb
