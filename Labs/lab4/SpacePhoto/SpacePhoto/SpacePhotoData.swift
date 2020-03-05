//
//  SpacePhotoData.swift
//  SpacePhoto
//
//  Created by Chad Brokaw on 3/3/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation

struct SpacePhoto: Codable {
    let date: String
    let explanation: String
    let title: String
    let url: String
}

struct SpacePhotoData {
    var data = [SpacePhoto]()
}
