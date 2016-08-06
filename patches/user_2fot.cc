44a45,50
> 
>   double etaMax1 = ph1_eta_max;
>   double etaMax2 = ph2_eta_max;
>   double etaMin1 = ph1_eta_min;
>   double etaMin2 = ph2_eta_min;
> 
45a52,54
>   if (p[-3].perp() <  p[-2].perp() ) swap(etaMax1,etaMax2);
>   if (p[-3].perp() <  p[-2].perp() ) swap(etaMin1,etaMin2);
> 
48a58,66
>   bool photon1incuts1 = (abs(p[-3].rapidity()) < etaMax1 && abs(p[-3].rapidity()) > etaMin1);
>   bool photon2incuts2 = (abs(p[-2].rapidity()) < etaMax2 && abs(p[-2].rapidity()) > etaMin2);
>   bool photon2incuts1 = (abs(p[-2].rapidity()) < etaMax1 && abs(p[-2].rapidity()) > etaMin1);
>   bool photon1incuts2 = (abs(p[-3].rapidity()) < etaMax2 && abs(p[-3].rapidity()) > etaMin2);
> 
>   bool acceptEvent = (photon1incuts1 && photon2incuts2) || (photon2incuts1 && photon1incuts2);
> 
>   if(!acceptEvent) return;
> 
116a135,137
>     // photon azimuthal angles
>     double phi1p = p[-3].phi(), phi2p = p[-2].phi();
> 
134a156
> 	std::swap(phi1p, phi2p);
138,146c160,175
< 	if (histvar[i] == "Mgg") var[i] = Mff;
< 	else if (histvar[i] == "eta") var[i] = etapar;
< 	else if (histvar[i] == "dphi") var[i] = PHIgg;
< 	else if (histvar[i] == "pTgg") var[i] = pT12;
< 	else if (histvar[i] == "pT") var[i] = pT;
< 	else if (histvar[i] == "CosP") var[i] = CosTHETAStar;
< 	else if (histvar[i] == "CosA") var[i] = CosTHETAStarApp;
<         else if (histvar[i] == "pT1") var[i] = pT1;
<         else if (histvar[i] == "pT2") var[i] = pT2;
---
>       if (histvar[i] == "Mgg") var[i] = Mff;
>       //else if (histvar[i] == "eta") var[i] = etapar;
>       else if (histvar[i] == "PT1") var[i] = pT1;
>       else if (histvar[i] == "PT2") var[i] = pT2;
>       else if (histvar[i] == "PTGG") var[i] = pT12;
>       else if (histvar[i] == "ETA1") var[i] = eta1p;
>       else if (histvar[i] == "ETA2") var[i] = eta2p;
>       else if (histvar[i] == "ETAGG") var[i] = deltay12;
>       else if (histvar[i] == "PHI1") var[i] = phi1p;
>       else if (histvar[i] == "PHI2") var[i] = phi2p;
>       else if (histvar[i] == "PHIGG") var[i] = PHIgg;
>       //else if (histvar[i] == "dphi") var[i] = PHIgg;
>       //else if (histvar[i] == "pTgg") var[i] = pT12;
>       //else if (histvar[i] == "pT") var[i] = pT;
>       else if (histvar[i] == "CosP") var[i] = CosTHETAStar;
>       else if (histvar[i] == "CosA") var[i] = CosTHETAStarApp;
148a178
> 
172,173c202,203
<     mf2 = 1.0*mu2;
<     mr2 = 1.0*mu2; 
---
>     mf2 = facscalefactor*facscalefactor*mu2;
>     mr2 = renscalefactor*renscalefactor*mu2;
