function IIP3tot = cascadedIIP3(input)

Gtot = 1;
IIP3totLinInverse = 0;
for k = 1:length(input)
    IIP3totLinInverse = IIP3totLinInverse + Gtot/dbm2mw(input{k}{2});
    Gtot = Gtot * dbp2g(input{k}{1});
end

IIP3tot = mw2dbm(1/IIP3totLinInverse);