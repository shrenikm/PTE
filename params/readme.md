# Config

Config files that store parameters for different models/algorithms. Eg: The various physical models must obtain their parameters (mass, length, etc) from this directory.

* All model specific parameters in the project must be taken from this one directory.
* No model specific parameters must be hard-coded in any function or script.
* All names must begin with *config_*.
* *config_(name)_save.m* must be used to save the config files. Each config file must have a save script.
