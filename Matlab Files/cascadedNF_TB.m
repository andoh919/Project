close all;
clear all;
clc;

stg1gain = 10;
stg1NF = 3;

stg2gain = 13.97;
stg2NF = 6;

stg3gain = 14.77;
stg3NF = 6.98;

NFtot = cascadedNF({{stg1gain,stg1NF},{stg2gain,stg2NF},{stg3gain,stg3NF}})