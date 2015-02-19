MASTER_KEYRING = eos-master-keyring.gpg
MASTER_KEYS = \
	keys/master/MK1.pub \
	keys/master/MK2.pub \
	$(NULL)
$(MASTER_KEYRING): $(MASTER_KEYS)

APPS_KEYRING = eos-apps-keyring.gpg
APPS_COMPAT_KEYRING = eos-keyring.gpg
APPS_KEYS = \
	keys/signing/EAPPSERVERPROD1.pub \
	keys/signing/EAPPSERVERSTAG1.pub \
	$(NULL)
$(APPS_KEYRING): $(APPS_KEYS)

OSTREE_KEYRING = eos-ostree-keyring.gpg
OSTREE_KEYS = \
	keys/signing/ECOLSK1.pub \
	keys/signing/EOSK1.pub \
	$(NULL)
$(OSTREE_KEYRING): $(OSTREE_KEYS)

IMAGE_KEYRING = eos-image-keyring.gpg
IMAGE_KEYS = \
	keys/signing/EIS1.pub \
	$(NULL)
$(IMAGE_KEYRING): $(IMAGE_KEYS)

ALL_KEYRINGS = $(MASTER_KEYRING) $(APPS_KEYRING) $(OSTREE_KEYRING) \
	$(IMAGE_KEYRING)
ALL_KEYS = $(MASTER_KEYS) $(APPS_KEYS) $(OSTREE_KEYS) $(IMAGE_KEYS)
EXTRA_DIST = $(ALL_KEYS)

keyringdir = $(datadir)/keyrings
keyring_DATA = $(ALL_KEYRINGS)

apps_keyringdir = $(datadir)/eos-app-manager
apps_keyring_DATA = $(APPS_KEYRING)

ostree_keyringdir = $(datadir)/ostree/trusted.gpg.d
ostree_keyring_DATA = $(OSTREE_KEYRING)

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
