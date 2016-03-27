//
//  ImageDownloaderClient.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation
import UIKit

typealias ImageDownloaderHandler = (UIImage?, Error?) -> Void
/**
 * This is subclass of HTTPClient which will download image from server
 */
class ImageDownloaderClient : HttpClient {
    static let sharedInstance  = ImageDownloaderClient()
    private let imageCache = NSCache()
    /**
     * @breif this method will download image from provided URL and will execute
     * completion handler
     * @param urlString to download image
     * @param compltionHandler method will execute handler after finishing download
     * @return void
     */
    func getImageFromURL(urlString:String, completionHandler:ImageDownloaderHandler) {
        guard urlString.isEmpty == false else {
            completionHandler(.None, Error.InvalidURL)
            return
        }
        
        guard let url = NSURL(string: urlString) else {
            completionHandler(.None, Error.InvalidURL)
            return
        }
        
        // Check if already exist in cache
        if let i = imageCache.objectForKey(urlString) as? UIImage {
            completionHandler(i, .None)
            return
        }
        
        fetchDataFromServer(url) { (data, error) in
            guard error == .None else {
                completionHandler(.None, error)
                return
            }
            guard let imageData = data else {
                completionHandler(.None, Error.NoData)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completionHandler(.None, Error.InvalidData)
                return
            }
            self.imageCache.setObject(image, forKey: urlString)
            completionHandler(image, .None)
        }
    }
}