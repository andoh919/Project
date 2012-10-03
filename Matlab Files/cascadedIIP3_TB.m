close all;
clear all;
clc;

% stg1gain = 8;
% stg1IIP3 = 20;
% stg2gain = 6;
% stg2IIP3 = 28;
% stg3gain = 5;
% stg3IIP3 = 40;
% input = {{stg1gain,stg1IIP3},{stg2gain,stg2IIP3},{stg3gain,stg3IIP3}};

stg1gain = 18.6;
stg1IIP3 = 19.4;
stg2gain = 1;
stg2IIP3 = 28.2;
input = {{stg1gain,stg1IIP3},{stg2gain,stg2IIP3}};

IIP3tot = cascadedIIP3(input)