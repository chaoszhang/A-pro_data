#!/bin/bash 

cat $1 |sed "s@ spar[^:]*@ spar@g" |sed "s@ smik[^:]*@ smik@g" | sed "s@ sbay[^:]*@ sbay@g" | sed "s@ IPF[^:]*@ cgla@g" | sed "s@ CAGL[^:]*@ cgla@g" | sed "s@ scas[^:]*@ scas@g" | sed "s@ kwal[^:]*@ kwal@g" | sed "s@ KLLA[^:]*@ klac@g" | sed "s@ AAT[^:]*@ klac@g" | sed "s@ A[^:]*@ agos@g" | sed "s@ CLUG[^:]*@ clus@g" | sed "s@ DEHA[^:]*@ dhan@g" | sed "s@ CGUG[^:]*@ cgui@g" | sed "s@ CTRG[^:]*@ ctro@g" | sed "s@ Caal[^:]*@ calb@g" | sed "s@ orf19[^:]*@ calb@g" | sed "s@ CPAG[^:]*@ cpar@g" | sed "s@ LELG[^:]*@ lelo@g" | sed "s@ Y[^:]*@ scer@g" | sed "s@ Q[^:]*@ scer@g" | sed "s@ @@g" | tr -d '\n'  | sed "s@)[^,);]*@)@g" | sed "s@:[^,)]*@@g" | sed "s@;@;\n@g"

