TARGETS=libdvbapi.so
 
CFLAGS += -fPIC -O2 -std=gnu99 -I../include -mglibc -march=34kc
CFLAGS += -ldl

all: ${TARGETS} 
    	
libdvbapi.so: dvbapi.c hook.c C_support.c $(wildcard *.h) $(wildcard ../include/*.h)
	$(CC) $(filter %.c %.cpp,$^) ${CFLAGS} -mel -shared -Wl,-soname,$@ -o $@

clean:
	rm -f ${TARGETS}

ifeq (${TARGET_IP}, )
endif

install: ${TARGETS}
	ping -c1 -W1 -w1 ${TARGET_IP} >/dev/null && \
        lftp -v -c "open ${TARGET_IP};cd ${TARGET_DEST_DIR};mput $^;"

.PHONY: clean
.PHONY: install
