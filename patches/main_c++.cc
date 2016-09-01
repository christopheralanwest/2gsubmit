108a109
>     else if (var=="PHI1" || var=="PHI2" || var=="PHIGG") return "rad";
113,119c114,125
<     if (var=="Mgg") return "m_{#gamma#gamma}";
<     else if (var=="eta") return "#eta_{#gamma#gamma}";
<     else if (var=="pT") return "p_{T}"; // what's this??
<     else if (var=="pTgg") return "p_{T,#gamma#gamma}";
<     else if (var=="dphi") return "#Delta#phi";
<     else if (var=="CosP") return "cos#theta*";
<     else if (var=="CosA") return "cos#theta*";
---
>   if (var=="Mgg") return "M_{#gamma#gamma}";
>   else if (var=="PT1") return "p_{T,1}";
>   else if (var=="PT2") return "p_{T,2}";
>   else if (var=="PTGG") return "p_{T,#gamma#gamma}";
>   else if (var=="ETA1") return "#eta_{1}";
>   else if (var=="ETA2") return "#eta_{2}";
>   else if (var=="ETAGG") return "#Delta#eta";
>   else if (var=="PHI1") return "#phi_{1}";
>   else if (var=="PHI2") return "#phi_{2}";
>   else if (var=="PHIGG") return "|#Delta#phi|";
>   else if (var=="CosP") return "cos#theta*";
>   else if (var=="CosA") return "cos#theta*";
156a163
> 	    hists[idhist]->Sumw2();
