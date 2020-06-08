//
//  InternetConnection.swift
//  CheckUpEmployee
//
//  Created by kasper on 6/7/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
import Network
class InternetConnection {
    
    
    class func checkInternetConnection(iCheckConnection:ICheckConnection){
    
        
      
        
    let monitor = NWPathMonitor()
        
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
                      

           
           monitor.pathUpdateHandler = { pathUpdateHandler in
                      if pathUpdateHandler.status == .satisfied {
                          print("Internet connection is on.")
                        
                    
                        
                        
                        DispatchQueue.main.async {
                        
                            iCheckConnection.onSucessfullyConnected()
                        
                                               }
                        
                        
                      }
                      else{
               
                      DispatchQueue.main.async {
                                            
                                                iCheckConnection.onFailConnected()
                                            
                                                                   }
                         
               }
           
       
       }
            monitor.start(queue: queue)
    


       }
       
    
    
    
    
    
    
    
    


    
    
    
}


