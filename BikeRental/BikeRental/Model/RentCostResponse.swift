//
//  RentCostResponse.swift
//  BikeRental
//
//  Created by Alvaro Barros on 17/03/23.
//

import Foundation

struct RentCostResponse: Codable {
  let rentAmount: Float
  let fee: Float
  let totalAmount: Float
}

struct RentCostError: Codable {
  let errorType: String
  let message: String
}
