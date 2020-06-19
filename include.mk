SRC_DIR:=src
INC_DIR:=include
DEP_DIR:=dep
OBJ_DIR:=obj

SRC_FILES:=$(wildcard $(SRC_DIR)/*.c)
DEP_FILES:=$(patsubst $(SRC_DIR)/%.c,$(DEP_DIR)/%.d,$(SRC_FILES))
OBJ_FILES:=$(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))

CC:=gcc

CFLGAS_BASE:=-std=c89 -pedantic
CFLAGS_WARN:=-Wall -Wextra -Wmissing-prototypes -Wstrict-prototypes -Wold-style-definition
CFLAGS_DBG=$(CFLAGS_BASE) $(CFLAGS_WARN) -O0
CFLAGS_NODBG=$(CFLAGS_BASE) $(CFLAGS_WARN) -DNDEBUG -O2

ifeq ($(DBG),n)
  CFLAGS=$(CFLAGS_NODBG)
else
  CFLAGS=$(CFLAGS_DBG)
endif

all: $(OBJ_FILES)

$(DEP_DIR)/%.d: $(SRC_DIR)/%.c
	$(CC) -MM $< -MT $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$<) -I$(INC_DIR) $< > $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -I$(INC_DIR) -c $< -o $@

.PHONY: clean

clean:
	@rm -f $(DEP_DIR)/* $(OBJ_DIR)/*

include $(DEP_FILES)
