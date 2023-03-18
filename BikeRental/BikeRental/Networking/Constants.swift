//
//  Constants.swift
//  BikeRental
//
//  Created by Gonzalo Barrios on 10/10/22.
//

import Foundation

struct Constants {
    static let bikeListURL = "https://trio-bike-rent-api.herokuapp.com/api/bikes/available"
    static let calculateTotalPriceURL = "https://trio-bike-rent-api.herokuapp.com/api/bikes/amount"
    static let finalizeBikeRentURL = "https://trio-bike-rent-api.herokuapp.com/api/bikes/rent"
    static let token = "9edc788e-8877-418a-8d97-11e846752d64"
    static let candidateToken = ProcessInfo.processInfo.environment["candidateToken"] ?? ""
    static let userId = ProcessInfo.processInfo.environment["userId"] ?? ""
}
