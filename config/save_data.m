function save_data(config_struct, var_name)
mydir  = pwd;
idcs   = strfind(mydir,'/');
newdir = mydir(1:idcs(end)-1);

path = strcat(newdir, '/data/', var_name, '.mat');
save(path, config_struct);
end