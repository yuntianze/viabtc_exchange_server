TARGET  := libnetwork.a
INCS = -I ../utils

# 创建 obj 目录变量
OBJ_DIR = obj

CFLAGS += -Wall -Wno-strict-aliasing -Wno-uninitialized -g -rdynamic -c
LFLAGS += -g -rdynamic

HEADERS = $(wildcard *.h)
SRCS = $(wildcard *.c)
# 修改 OBJS 路径，保持源文件的目录结构
OBJS := $(SRCS:%.c=$(OBJ_DIR)/%.o)

LIBS = -lm -lpthread -ldl -lmysqlclient -lev -ljansson -lmpdec -lrdkafka -lz -lssl -lcrypto

.PHONY: all clean

all: $(TARGET)

# 创建 obj 目录
$(shell mkdir -p $(sort $(dir $(OBJS))))

# 链接目标文件生成可执行文件
$(TARGET): $(OBJS)
	$(AR) cr $@ $(OBJS)
	ranlib $@

# 重写编译规则，保持源文件的目录结构
$(OBJ_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(INCS) -c $< -o $@

# 添加清理规则
clean:
	rm -rf $(OBJ_DIR) $(TARGET)
