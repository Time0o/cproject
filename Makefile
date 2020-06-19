SHELL:=bash

SELF:=$(shell echo "$$PWD")

TEMPLATE_DIR:=templates

.PHONY: init

ifndef ROOT
  $(error ROOT not set)
endif

init:
	@cp -r $(TEMPLATE_DIR)/tree/{*,.??*} $(ROOT)
	@echo "include $(SELF)/include.mk" > $(ROOT)/Makefile
