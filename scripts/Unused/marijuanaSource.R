# The functionality of this file has been incorporated into the cleanDataFnct.R file

marijuanaSource <- function(data) {
        
        for(i in 1:length(data[,1])) {
                if (grepl("oil", data$Source[i], ignore.case = TRUE)) {
                        data$MainSource[i] = "Hash Oil"
                        print("Hash Oil")
                }
                if (grepl("brownie", data$Source[i], ignore.case = TRUE)) {
                        data$MainSource[i] = "Brownies"
                        print("Brownies")
                }
                if (grepl("cookies", data$Source[i], ignore.case = TRUE)) {
                        data$MainSource[i] = "Cookies"
                        print("Cookies")
                }
                if (grepl("candy", data$Source[i], ignore.case = TRUE)) {
                        data$MainSource[i] = "Candy Bars"
                        print("Candy Bars")
                }
                if (grepl("food", data$Source[i], ignore.case = TRUE)) {
                        data$MainSource[i] = "Other Fodd"
                        print("Other Food")
                }
                else {
                        data$MainSource[i] = "Marijuana Plant"
                        print("NA")
                }
        }
       # return(data)
                
}
        
        
# Categories to keep: Candy Bars, Cookies, Brownies, Drinks, Hash Oil, Marijuana Plant, Misc.


                                                                                
#[2] "butane hash oil ((slang term for concentrated thc))"                                  
#[3] "cannabidiol"                                                                          
#[4] "cannabis sativa"                                                                      
#[5] "concentrated thc"                                                                     
#[6] "dab ((slang term for concentrated thc))"                                              
#[7] "dabs((slang term for concentrated thc))"                                              
#[8] "hash oil ((concentrated thc) )"                                                       
#[9] "hashish"                                                                              
#[10] "marijuana"                                                                            
#[11] "marijuana brownie"                                                                    
#[12] "marijuana candy"                                                                      
#[13] "marijuana containing beverage"                                                        
#[14] "marijuana containing drink"                                                           
#[15] "marijuana containing food (other)"                                                    
#[16] "marijuana cookies"                                                                    
#[17] "marijuana oil"                                                                        
#[18] "marijuana, crude extract"                                                             
#[19] "marijuana, plant"                                                                     
#[20] "marijuana(common name for cannabis sativa)"                                           
#[21] "marijuana(slang term) (marijuana)"                                                    
#[22] "medical marijuana"                                                                    
#[23] "pot (slang term)"                                                                     
#[24] "pot (slang term) (marijuana)"                                                         
#[25] "smash (slang term) (marijuana cooked with acetone, resulting oil is added to hashish)"
#[26] "thc"                                                                                  
#[27] "thc (tetrahydrocannabinol)"                                                           
#[28] "wax((slang term for concentrated thc))"                                               
#[29] "weed"                                                                                 
#[30] "weed (slang term) (marijuana)" 