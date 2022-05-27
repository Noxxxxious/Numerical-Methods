clc
close all

warning('off', 'all')

load trajektoria1

N = 90;
[ wsp_wielomianu, xa ] = aprox_poly(n,x,N);  % aproksymacja wsp. 'x'.


