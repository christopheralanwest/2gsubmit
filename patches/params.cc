17a18,22
> double ph1_eta_max = 2.37; 
> double ph2_eta_max = 2.37; 
> double ph1_eta_min = 2.37; 
> double ph2_eta_min = 2.37; 
> 
73a79,81
> double renscalefactor = 1;
> double facscalefactor = 1;
> 
92a101,104
>         else if (token=="ph1_eta_max") str >> ph1_eta_max;
>         else if (token=="ph2_eta_max") str >> ph2_eta_max;
>         else if (token=="ph1_eta_min") str >> ph1_eta_min;
>         else if (token=="ph2_eta_min") str >> ph2_eta_min;
115a128,130
> 	else if (token=="renscalefactor") str >> renscalefactor;
> 	else if (token=="facscalefactor") str >> facscalefactor;
>         else if (token=="PDFname") str >> pdf_.PDFname;
142a158,161
>     std::cout << "ph1_eta_max : " << ph1_eta_max << std::endl;
>     std::cout << "ph2_eta_max : " << ph2_eta_max << std::endl;
>     std::cout << "ph1_eta_min : " << ph1_eta_min << std::endl;
>     std::cout << "ph2_eta_min : " << ph2_eta_min << std::endl;
151a171,174
>     std::cout << "Renormalization and factorization scale factors (to compute uncertainties) " << std::endl;
>     std::cout << "renscalefactor: "<< renscalefactor << std::endl;
>     std::cout << "facscalefactor: "<< facscalefactor << std::endl;
>     std::cout << "PDFname: " << PDFname << std::endl;
