//
//  state-cities.swift
//  locations
//
//  Created by Chad Brokaw on 2/4/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation

struct StateCities: Decodable {
    let state: String
    let cities: [String]
}
