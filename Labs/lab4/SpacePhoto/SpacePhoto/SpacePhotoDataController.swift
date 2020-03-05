//
//  SpacePhotoDataController.swift
//  SpacePhoto
//
//  Created by Chad Brokaw on 3/3/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case BadURL
    case BadResponse
    case CouldNotParse
}

class SpacePhotoDataController {
    var spaceData = SpacePhotoData()
    
    var onDataUpdate: ((_ data: [SpacePhoto]) -> Void)?
    
    func loadJSON(date: String) throws {
        let urlPath = "https://api.nasa.gov/planetary/apod?api_key=Kos0EhiYnP1KlmSF2pl39Wkdqfnqjb12CE1z4O30&date=\(date)"
        
        guard let url = URL(string: urlPath) else {
            throw JSONError.BadURL
        }
        
        let group = DispatchGroup()
        group.enter()
        
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            
            let statusCode = httpResponse.statusCode
            
            guard statusCode == 200 else {
                print("File Download Error")
                return
            }
            
            print("download complete")
            
            DispatchQueue.main.async { self.parseJson(rawData: data!, date: date, url: urlPath)}
        })
        
        session.resume()
    }
    
    func parseJson(rawData: Data, date: String, url: String) {
        print(rawData)
        do {
            let parsedData = try JSONDecoder().decode(SpacePhoto.self, from: rawData)
            spaceData.data.removeAll()
            spaceData.data.append(parsedData)
            print(parsedData)
        }
        catch {
            print("json error with date: \(date) and url: \(url)")
            print(error.localizedDescription)
        }
        
        print("parseJSON done")
        onDataUpdate?(spaceData.data)
    }
}
