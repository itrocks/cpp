FILES := main
override CXXFLAGS += -lpthread -Wconversion -std=c++17 -Isrc -IuWebSockets/src -IuWebSockets/uSockets/src
override LDFLAGS += uWebSockets/uSockets/*.o -lz

DESTDIR ?=
prefix ?= /usr/local

# WITH_PROXY enables PROXY Protocol v2 support
ifeq ($(WITH_PROXY),1)
	override CXXFLAGS += -DUWS_WITH_PROXY
endif

# WITH_OPENSSL=1 enables OpenSSL 1.1+ support
ifeq ($(WITH_OPENSSL),1)
	# With problems on macOS, make sure to pass needed LDFLAGS required to find these
	override LDFLAGS += -lssl -lcrypto
else
	# WITH_WOLFSSL=1 enables WolfSSL 4.2.0 support (mutually exclusive with OpenSSL)
	ifeq ($(WITH_WOLFSSL),1)
		override LDFLAGS += -L/usr/local/lib -lwolfssl
	endif
endif

# WITH_LIBUV=1 builds with libuv as event-loop
ifeq ($(WITH_LIBUV),1)
	override LDFLAGS += -luv
endif

# WITH_ASAN builds with sanitizers
ifeq ($(WITH_ASAN),1)
	override CXXFLAGS += -fsanitize=address
	override LDFLAGS += -lasan
endif

.PHONY: main
main:
	for FILE in $(FILES); do $(CXX) -pthread -flto -O3 $(CXXFLAGS) src/$$FILE.cpp -o dist/$$FILE $(LDFLAGS) & done; \
	wait

install:

all:
	$(MAKE) main
clean:
	rm -rf dist/$(FILES)
