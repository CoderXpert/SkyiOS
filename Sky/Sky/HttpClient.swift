//
//  HttpClient.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation

typealias HttpClientCompletionHandler = (NSData?, Error?) -> Void

/**
 * HTTP Client class, all clients need to fetch data from server should subclass
 * this
 */
class HttpClient {
    
    /**
     * This method will get data from server, all call to server should route from here
     * @param URL from where data need to fetch
     * @param CompletionHandler
     * @return void, completion handler will be called once finish execution
     */
    func fetchDataFromServer(url : NSURL, completionHandler : HttpClientCompletionHandler){
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig)
        let request = NSURLRequest(URL: url)
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, networkError) -> Void in
            
            // Check network error
            guard networkError == nil else {
                let error = Error.NetworkError
                print(error)
                completionHandler(.None, error)
                return
            }
            
            guard let unwrappedData = data else {
                completionHandler(nil, Error.NoData)
                return
            }
            
            completionHandler(unwrappedData,nil)
            
        })
        task.resume()
    }
}