clear
clc

kappas = [0.05, 0.1, 0.25, 0.5];
betas = 0.6:0.1:2.5;


for i=1:length(betas)
    beta = betas(i);
    root_path=['/net/archive/groups/plggabm/bornholdt-results/',num2str(beta),'/j1/1/j2/0/'];
    
    for j=1:length(kappas)
        kappa = kappas(j);
        mkdir([root_path,'kappa/',num2str(kappa)]);
        matching_file_names = dir([root_path,'*-kappa-*',num2str(kappa),'*.mat']);
        for k = 1:length(matching_file_names)
            file_name = [matching_file_names(k).folder,'/',matching_file_names(k).name];
            fprintf('Copying file [%s]',file_name);
            movefile([file_name], [root_path,'kappa/',num2str(kappa),'/']);
        end
    end
    
end