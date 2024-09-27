//
//  Bike.swift
//  BikeRental
//
//  Created by Gonzalo Barrios on 9/27/22.
//

import Foundation

struct Bike: Codable {

    let id: Int
    let candidateId: Int
    let name: String
    let type: String
    let bodySize: Int
    let maxLoad: Int
    let rate: Int
    let description: String
    let ratings: Float
    let imageUrls: [String]

}

extension Bike {
  static let testBike = Bike(id: 1,
                             candidateId: 1,
                             name: "Murazik, Thiel and Robel",
                             type: "Cyclocross Bicycle",
                             bodySize: 24,
                             maxLoad: 110,
                             rate: 109,
                             description: "",
                             ratings: 4.8,
                             imageUrls: ["https://cremecycles.com/images/glowne/13.jpg"])
}
