# Data

This folder all the collected data.

* Each data file must be a .mat file, with the name indicating the system that was used to create it.
* The directory must only contain data files.
* Each data file must have a corresponding entry in file details.

## File details

* cartpole_data_1.mat - Data for x0 = [10, x, 0, 0] and xf = [10, pi, 0, 0]
    x is in [-pi/2, pi/2].

* dubin_data_1.mat - Data for 3 trajectories. The first one is for [5; 5; 0; 0; 0; 0] to 
    [10; 10; pi/2; 0; 0; 0]. The other two trajectories are taken from
    [rand(3, 7); rand(3, 7); rand(-pi/2, pi/2); 0; 0; 0] to
    [rand(7, 15); rand(7, 15); rand(-pi/2, pi/2); 0; 0; 0]