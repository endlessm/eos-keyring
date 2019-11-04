AC_INIT([eos-keyring], [2.0+2014.05.15])

AM_INIT_AUTOMAKE([foreign])
AM_SILENT_RULES([yes])

AC_PROG_MKDIR_P
AC_PROG_LN_S
AC_CHECK_PROG([GPG], [gpg], [gpg], [AC_MSG_ERROR([gpg not found in PATH])])
AC_CHECK_PROG([OPENSSL], [openssl], [openssl],
              [AC_MSG_ERROR([openssl not found in PATH])])

AC_CONFIG_FILES([Makefile])
AC_REQUIRE_AUX_FILE([tap-driver.sh])
AC_OUTPUT
