//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Parveen Yadav on 3/22/15.
//  Copyright (c) 2015 Parveen Yadav. All rights reserved.
//

import Foundation

/**
*  <#Description#>
*/
class RecordedAudio: NSObject{
    /**
    *  <#Description#>
    */
    var filePathUrl: NSURL!
    /**
    *  <#Description#>
    */
    var title: String!
    
    /**
    <#Description#>
    
    :returns: <#return value description#>
    */
    init(filePathUrl:NSURL, title:String){
        self.filePathUrl = filePathUrl
        self.title = title
        
    }
}