% qtdecomp_var.m- quadtree decomposition based on variance
%**************************************************************************
% [S] = qtdecomp_var(I, var_weight)
%
% author: Elena Ranguelova
% date created: 31.03.2010
% last modification date: 
% modification details: 
%**************************************************************************
% INPUTS:
% I - gray scale square image
% var_weight- weight for the variance criterion [optional] (default is 1)
%**************************************************************************
% OUTPUTS:
% S- sparse matrix representing the quadtree structure after decomposition
%    based on varience
%**************************************************************************
% NOTES: qtdecomp with custom function
%**************************************************************************
% EXAMPLES USAGE: see ex_qtdecomp_var.m
%**************************************************************************
% REFERENCES: 
%**************************************************************************
function [S] = qtdecomp_var(I, var_weight)
global IMVAR
%**************************************************************************
% input control    
%--------------------------------------------------------------------------
if nargin <2
    var_weight = 1;
elseif nargin < 1
    error('qtdecomp_var requires at least one input parameter!');
else
    [nrows, ncols, ndims] = size(I);
    if ndims >2
        error('The input image should be gray-scale!');
    elseif nrows ~= ncols
        error('The input image should be square!');
    end
end
%**************************************************************************
% constants/hard-set parameters
%--------------------------------------------------------------------------
%**************************************************************************
% input parameters -> variables
%--------------------------------------------------------------------------
I = double(I);
%**************************************************************************
% initialisations
%--------------------------------------------------------------------------
S = [];
%**************************************************************************
% computations
%--------------------------------------------------------------------------
% pre-processing
%--------------------------------------------------------------------------
IMVAR = var(I(:))*var_weight;
% parameters depending on pre-processing
%--------------------------------------------------------------------------
% core processing
%--------------------------------------------------------------------------
[S] = qtdecomp(I, @block_var);
%**************************************************************************
% variables -> output parameters
%--------------------------------------------------------------------------
%**************************************************************************
% subfunctions
%--------------------------------------------------------------------------
function split = block_var(blocks)
% the splitting criteria
global IMVAR
% varience of each block
var_blocks = var(var(blocks, [], 1), [], 2);
split = var_blocks >= IMVAR;
