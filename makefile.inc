# Common definitions
CC := gcc
AR := ar

# Common flags
CFLAGS := -Wall -Wno-strict-aliasing -Wno-uninitialized -g -rdynamic
LFLAGS := -g -rdynamic

# Default target
.PHONY: all clean

# Default pattern rules
%.o: %.c
	$(CC) $(CFLAGS) $(INCS) -c $< -o $@

# Default clean rule (can be overridden)
clean-default:
	rm -rf *.o *.a $(TARGET)