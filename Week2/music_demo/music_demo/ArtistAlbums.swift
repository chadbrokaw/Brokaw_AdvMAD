//
//  ArtistAlbums.swift
//  music_demo
//
//  Created by Chad Brokaw on 1/23/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation

struct ArtistAlbum: Decodable {
    let name: String
    let albums: [String]
}
