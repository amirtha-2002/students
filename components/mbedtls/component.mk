#
# Component Makefile
#

COMPONENT_ADD_INCLUDEDIRS := port/include mbedtls/include port/include/$(IDF_TARGET)

COMPONENT_SRCDIRS := mbedtls/library port port/$(IDF_TARGET)

COMPONENT_OBJEXCLUDE := mbedtls/library/net_sockets.o

ifdef CONFIG_MBEDTLS_SSL_PROTO_GMTSSL1_1
COMPONENT_OBJEXCLUDE += \
mbedtls/library/ssl_ciphersuites.o \
mbedtls/library/ecp.o \
mbedtls/library/cipher_wrap.o \
mbedtls/library/oid.o \
mbedtls/library/ecp_curves.o \
mbedtls/library/pk_wrap.o \
mbedtls/library/ecdsa.o \
mbedtls/library/x509_crt.o \
mbedtls/library/ssl_tls.o \
mbedtls/library/ssl_cli.o
endif

COMPONENT_SUBMODULES += mbedtls

ifdef CONFIG_MBEDTLS_DYNAMIC_BUFFER

WRAP_FUNCTIONS = mbedtls_ssl_handshake_client_step \
                 mbedtls_ssl_handshake_server_step \
                 mbedtls_ssl_read \
                 mbedtls_ssl_write \
                 mbedtls_ssl_session_reset \
                 mbedtls_ssl_free \
                 mbedtls_ssl_setup \
                 mbedtls_ssl_send_alert_message \
                 mbedtls_ssl_close_notify

WRAP_ARGUMENT := -Wl,--wrap=

COMPONENT_ADD_LDFLAGS = -l$(COMPONENT_NAME) $(addprefix $(WRAP_ARGUMENT),$(WRAP_FUNCTIONS))

COMPONENT_SRCDIRS += port/dynamic

endif
