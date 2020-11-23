//
//  Post.swift
//  FitBook2
//
//  Created by BAR SEGEV on 7/1/20.
//  Copyright © 2020 BAR SEGEV. All rights reserved.
//

import Foundation
class Post {
    var caption: String
    var photoUrl: String
    
    init(captionText: String, photoUrlString: String) {
        caption = captionText
        photoUrl = photoUrlString
    }
}
