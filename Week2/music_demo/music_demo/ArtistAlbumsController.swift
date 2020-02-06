//
//  ArtistAlbumsController.swift
//  music_demo
//
//  Created by Chad Brokaw on 1/23/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation

enum DataError: Error {
    case BadFilePath
    case CouldNotDecodeData
    case NoData
}

class ArtistAlbumsController {
    // properties
    var artistAlbumsData: [ArtistAlbum]?
    let filename = "artist-albums"
    
    // read from plist and decode to array of ArtistAlbums struct
    func loadData() throws {
        
    }
    
    // get all the artists and return array of string
    func getAllArtists() throws -> [String] {
        print("Loading Data.....")
        var artists = [String]()
        
        if let data = artistAlbumsData {
            for artistStruct in data {
                artists.append(artistStruct.name)
            }
            return artists
        }
        else {
            throw DataError.NoData
        }
//        if let pathUrl = Bundle.main.url(forResource: filename, withExtension: "plist")
    }
    
    // get all the albums for any of the artists
    func getAlbums(idx: Int) throws -> [String] {
        
        var artists = [String]()
        
        if let data = artistAlbumsData {
            for artistStruct in data {
                artists.append(artistStruct.name)
            }
            return artists
        }
        else {
            throw DataError.NoData
        }
    }
    
}
