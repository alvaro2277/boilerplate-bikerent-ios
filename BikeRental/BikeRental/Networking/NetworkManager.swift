//
//  NetworkManager.swift
//  BikeRental
//
//  Created by Gonzalo Barrios on 9/27/22.
//

import Foundation
import Alamofire

class NetworkManager {
    
    class func fetchBikes(completionHandler: @escaping ([Bike]) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": Constants.candidateToken,
            "Accept": "application/json"
        ]

        AF.request(Constants.bikeListURL, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let decoder = JSONDecoder()
                let bikeList: [Bike] = try! decoder.decode([Bike].self, from: data)
                completionHandler(bikeList)
            case .failure(let error):
                print(error)
                completionHandler([])
            }
        }
    }

  class func finalizeBikeRent(for bikeId: Int, user: Int, startDate: String, endDate: String, completionHandler: @escaping (Bool) -> Void) {
    let headers: HTTPHeaders = [
      "Authorization": Constants.candidateToken,
      "Content-Type": "application/json"
    ]

    let param: Parameters = [
      "bikeId": bikeId,
      "userId": user,
      "dateFrom": startDate,
      "dateTo": endDate
    ]

    AF.request(Constants.finalizeBikeRentURL,
               method: .post,
               parameters: param,
               encoding: JSONEncoding.default,
               headers: headers)
    .responseJSON { response in
      switch response.result {
        case .success:
          guard let data = response.data else { return }
          let decoder = JSONDecoder()
          do {
            let _: FinalizingBookingResponse = try decoder.decode(FinalizingBookingResponse.self, from: data)
            completionHandler(true)
          } catch {
            let error: FinalizeBookingError = try! decoder.decode(FinalizeBookingError.self, from: data)
            print(error)
            completionHandler(false)
          }
        case .failure(let error):
          print(error)
          completionHandler(false)
      }
    }
  }

  class func getFinalRentPrice(for bikeId: Int, user: Int, startDate: String, endDate: String, completionHandler: @escaping (RentCostResponse?) -> Void) {
    let headers: HTTPHeaders = [
      "Authorization": Constants.candidateToken,
      "Content-Type": "application/json"
    ]

    let param: Parameters = [
      "bikeId": bikeId,
      "userId": user,
      "dateFrom": startDate,
      "dateTo": endDate
    ]

    AF.request(Constants.calculateTotalPriceURL,
               method: .post,
               parameters: param,
               encoding: JSONEncoding.default,
               headers: headers)
    .responseJSON { response in
      switch response.result {
        case .success:
          guard let data = response.data else { return }
          let decoder = JSONDecoder()
          do {
            let priceResponse: RentCostResponse = try decoder.decode(RentCostResponse.self, from: data)
            completionHandler(priceResponse)
          } catch {
            let error: RentCostError = try! decoder.decode(RentCostError.self, from: data)
            print(error)
          }
        case .failure(let error):
          print(error)
          completionHandler(nil)
      }
    }
  }
}
