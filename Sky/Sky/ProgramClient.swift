//
//  ProgramClient.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation

typealias ProgramClientCompletionHandler = ([ProgramType]?, Error?) -> Void

class ProgramClient : HttpClient {
    internal let API_END_POINT = "http://content.ott.sky.com/v2/brands/go/devices/ios/navigation/nodes/177da30fc6850410VgnVCM100000625112ac____/pages/7908e6066a051410VgnVCM1000000b43150a____?represent=(item-group/item-group(item/item-summary(broadcast-channel/broadcast-channel)))"
   
    /**
     * @breif This method will construct url 
     * @param no
     * @return optional url
     */
    internal func constructURL()-> NSURL? {
        guard let components = NSURLComponents(string:API_END_POINT) else {
            return nil
        }
        return components.URL
    }
    /**
     * @breif private method used by to invoke superclass fetchDataFromURL
     * @param url:NSURL to fetch data from
     * @param handler:HTTPClientCompletionHandler which will be executed once get data
     */
    internal func getDataFromURL(url:NSURL,completionHandler:HttpClientCompletionHandler) {
        print("URL : \(url.absoluteString)")
        fetchDataFromServer(url, completionHandler: completionHandler)
    }
    
    /**
     * @breif this method will feath all popular programs
     * @param completionHandler which will be execute after finish download
     * @return void
     */
    func fetchAllProgramsFromServer(completionHandler:ProgramClientCompletionHandler){
        guard let url = constructURL() else {
            completionHandler(.None, Error.InvalidURL)
            return
        }
        getDataFromURL(url) { (data, error)in
            guard error == .None else {
                completionHandler(.None, error)
                return
            }
            guard let jsonDta = data else {
                completionHandler(nil, Error.NoData)
                return
            }
            // let pass it to parser
            self.parseAllProgramData(jsonDta, completionHandler: completionHandler)
        }
    }
    
}
extension ProgramClient {
    /**
     * @breif this method will parse jsonData and will create Program objects
     * @param data:NSData to parse 
     * @param completionHandler which will be execute after finishing parsing 
     * @return void
     */
    func parseAllProgramData(data:NSData, completionHandler:ProgramClientCompletionHandler){
       
        let json = JSON(data: data)
        guard let array = json["_links"].array else {
            completionHandler(.None, Error.InvalidData)
            return
        }
        
        var itemsArray:[JSON]?
        for item in array {
            if item["_rel"].string == "item-group/item-group"{
                itemsArray = item["_links"].array
                break
            }
        }
        
        guard let items = itemsArray else {
            completionHandler(.None, Error.InvalidData)
            return
        }
        
        // Items have value lets create programs array
        var programs = [ProgramType]()
        
        for item in items {
            guard item["_rel"] == "item/item-summary" else {
                continue
            }
            
            let title = item["title"].string
            let shortDescription = item["shortDescription"].string
            let synopsis = item["synopsis"].string
            let broadcastChannel = item["broadcastChannelValue"].string
            
            //: Detail info
            let releaseYear = item["yearOfRelease"].int
            let duration = item["durationMinutes"].int
            let cert = item["certificate"].string
            
            
            
            var imageArray = [Image]()
            let images = item["images"].array
            if images != nil {
                for imageItem in images! {
                    guard let width = imageItem["width"].double,
                    height = imageItem["height"].double,
                    url = imageItem["url"].string,
                        type = imageItem["type"].string else {
                            continue
                    }
                    let image = Image(width:width, height: height, url: url, type: type)
                    imageArray.append(image)
                }
            }
            
            let program = Program(title: title, shortDescription: shortDescription, synopsis: synopsis, images: imageArray, broadcastChannel: broadcastChannel)
            
            //: detail info 
            program.releaseYear = releaseYear
            program.certificate = cert
            program.duration = duration
            
            programs.append(program)
            
        }
        
        guard programs.count > 0 else {
            completionHandler(.None, Error.InvalidData)
            return
        }
        
        completionHandler(programs, .None)
        
    }
}