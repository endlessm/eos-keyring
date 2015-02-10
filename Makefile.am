MASTER_KEYRING = eos-master-keyring.gpg
MASTER_KEYS = \
	keys/master/MK1.pub \
	keys/master/MK2.pub \
	$(NULL)
$(MASTER_KEYRING): $(MASTER_KEYS)

APPS_KEYRING = eos-apps-keyring.gpg
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

ALL_KEYRINGS = $(MASTER_KEYRING) $(APPS_KEYRING) $(OSTREE_KEYRING)
ALL_KEYS = $(MASTER_KEYS) $(APPS_KEYS) $(OSTREE_KEYS)
EXTRA_DIST = $(ALL_KEYS)

keyringdir = $(datadir)/keyrings
keyring_DATA = $(MASTER_KEYRING) $(APPS_KEYRING) $(OSTREE_KEYRING)

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

CLEANFILES = $(ALL_KEYRINGS)
clean-local:
	rm -f *.gpg~
	rm -rf gnupg
