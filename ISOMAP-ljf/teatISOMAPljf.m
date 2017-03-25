function [ output_args ] = teatISOMAPljf( input_args )
%TEATISOMAP-LJF Summary of this function goes here
%   Detailed explanation goes here
clear;
load('UMist8.mat');
X=X6;
options.dims=10;

% load('COIL20Croped.mat');
% X=COILcrop;
% options.dims=10;

options.nntype = 0;options.nn_nbr = 9;

y = gxf_isomap(X,options);
y = y{1};

end

