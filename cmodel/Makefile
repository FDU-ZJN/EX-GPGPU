CXX ?= g++
AR ?= ar
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra
PYTHON_CONFIG ?= python3-config

.PHONY: all clean
all: libaec_cmodel_api.a

aec_cmodel_api.o: aec_cmodel_api.cpp aec_cmodel_api.h capi.py
	$(CXX) $(CXXFLAGS) $(shell $(PYTHON_CONFIG) --includes) -c $< -o $@

libaec_cmodel_api.a: aec_cmodel_api.o
	$(AR) rcs $@ $^

clean:
	rm -f aec_cmodel_api.o libaec_cmodel_api.a
