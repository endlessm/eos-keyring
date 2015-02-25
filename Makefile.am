KEYS = \
	keys/master/MK1.pub \
	keys/master/MK2.pub \
	keys/signing/EAPPSERVERPROD1.pub \
	keys/signing/EAPPSERVERSTAG1.pub \
	keys/signing/ECOLSK1.pub \
	keys/signing/EOSK1.pub \
	$(NULL)

EXTRA_DIST = $(KEYS)

keyringdir = $(datadir)/keyrings
keyring_DATA = eos-keyring.gpg

apps_keyringdir = $(datadir)/eos-app-manager
apps_keyring_DATA = eos-keyring.gpg

ostree_keyringdir = $(datadir)/ostree/trusted.gpg.d
ostree_keyring_DATA = eos-keyring.gpg

eos-keyring.gpg: $(KEYS)
	keys='$^'; for key in $$keys; do \
		$(GPG) --homedir . --no-default-keyring --keyring $@ --import $$key || exit 1; \
	done

CLEANFILES = eos-keyring.gpg
clean-local:
	rm -f *.gpg *.gpg~
