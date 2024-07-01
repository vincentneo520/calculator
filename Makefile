CC = gcc
CFLAGS = -Wall -O2
TARGET = calculator

INCLUDEDIR = include
LIBDIR = lib
SRCDIR = src

SRC = $(SRCDIR)/main.c
OBJS = $(SRC:.c=.o)

# 静态库和动态库目标
STATIC_LIB = $(LIBDIR)/libadd.a
DYNAMIC_LIB = $(LIBDIR)/libsub.so

# 链接库
LIBS = -L$(LIBDIR) -ladd -lsub

# 编译选项，包含路径和库路径
CFLAGS += -I$(INCLUDEDIR) -L$(LIBDIR)

all: $(STATIC_LIB) $(DYNAMIC_LIB) $(TARGET)

$(TARGET): $(OBJS)
    $(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LIBS)

$(STATIC_LIB): $(LIBDIR)/add.o
    ar rcs $@ $^

$(LIBDIR)/add.o: $(SRCDIR)/add.c
    $(CC) $(CFLAGS) -c $< -o $@

$(DYNAMIC_LIB): $(LIBDIR)/sub.o
    $(CC) -shared -o $@ $^

$(LIBDIR)/sub.o: $(SRCDIR)/sub.c
    $(CC) -fPIC $(CFLAGS) -c $< -o $@

clean:
rm -f $(TARGET) $(OBJS) $(LIBDIR)/*.o $(STATIC_LIB) $(DYNAMIC_LIB)
