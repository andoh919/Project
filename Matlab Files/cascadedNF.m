function NFtot = cascadedNF(input)

Gtot = 1;
for k = 1:length(input)
    if k == 1
        Ftot = nf2f(input{k}{2});
    else
        Ftot = Ftot + (nf2f(input{k}{2})-1)/Gtot;
    end
    Gtot = Gtot * dbp2g(input{k}{1});
end

NFtot = f2nf(Ftot);