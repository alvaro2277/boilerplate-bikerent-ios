//
//  FinalizeBookingResponse.swift
//  BikeRental
//
//  Created by Alvaro Barros on 17/03/23.
//

import Foundation

struct FinalizingBookingResponse: Codable {
  let rentAmount: Double
  let fee: Double
  let totalAmount: Double
}

struct FinalizeBookingError: Codable {
  let errorType: String
  let message: String
}
