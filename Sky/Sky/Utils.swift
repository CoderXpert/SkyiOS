//
//  Utils.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    class func postNotification(notif:String){
        NSNotificationCenter.defaultCenter().postNotificationName(notif, object: .None)
    }
    class func postNotificationOnMainThread(notif:String){
        dispatch_async(dispatch_get_main_queue(), {
            postNotification(notif)
        })
    }
}

extension UILabel{
    func heightOfLabel(width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return label.frame.height
    }
}