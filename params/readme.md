# Params

Contains functions that output parameters for different models/algorithms. Eg: The various physical models must obtain their parameters (mass, length, etc) from the functions in this directory.

* All model specific parameters in the project must be taken from this one directory.
* No model specific parameters must be hard-coded in any function or script.
* All names must begin with *initialize_*.
* *initialize_(name)_params.m* must be used as the function names.
