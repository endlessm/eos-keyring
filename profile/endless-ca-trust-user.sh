# Add Endless CA certificate to non-system user's NSS database

if [ "${UID:-$(id -u)}" -ge 1000 ]; then
    # Run quietly on login and don't fail
    endless-ca-trust-user >/dev/null || true
fi
