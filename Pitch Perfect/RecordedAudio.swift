//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Parveen Yadav on 3/22/15.
//  Copyright (c) 2015 Parveen Yadav. All rights reserved.
//

import Foundation

/**
*  Model class for stroing filepath and title
*/
class RecordedAudio: NSObject{
    /**
    *  audio file location
    */
    var filePathUrl: NSURL!
    /**
    *  title of audio file
    */
    var title: String!
    
    init(filePathUrl:NSURL, title:String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}