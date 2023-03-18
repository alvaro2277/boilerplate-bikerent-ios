//
//  BookingViewModel.swift
//  BikeRental
//
//  Created by Alvaro Barros on 17/03/23.
//

import Foundation
import SwiftUI

class BookingViewModel: ObservableObject {
  @Published var bikeImage: UIImage?
  @Published var selectedStartDate = ""
  @Published var selectedEndDate = ""
  @Published var dates: Set<DateComponents> = []
  @Published var rentValue: Float = 0.0
  @Published var rentFee: Float = 0.0
  @Published var rentTotal: Float = 0.0
  @Published var bookingFinalized = false
  @Published var showCalendar = false
  @Published var goToHomeTap = false

  var bike: Bike

  init(bike: Bike) {
    self.bike = bike
    getImage()
    setInitialDates()
  }

  private func setInitialDates() {
    let todayComponent = Calendar.current.dateComponents([.calendar, .era, .year, .month, .day], from: Date())
    let tomorrowComponent = Calendar.current.dateComponents([.calendar, .era, .year, .month, .day], from: Date.tomorrow)
    let monthInitialsStartDate = monthInitialsFromInt(month: todayComponent.month!)
    let monthInitialsEndDate = monthInitialsFromInt(month: tomorrowComponent.month!)

    selectedStartDate = "\(monthInitialsStartDate)/\(todayComponent.day!)"
    selectedEndDate = "\(monthInitialsEndDate)/\(tomorrowComponent.day!)"
    dates.insert(todayComponent)
    dates.insert(tomorrowComponent)
    getfinalRentPrice()

  }

  private func getImage() {
    guard let image = bike.imageUrls.first,
          let imageURL = URL(string: image) else { return }
    _ = ImageLoader.publicCache.loadImage(imageURL) { result in
        do {
            let image = try result.get()
            DispatchQueue.main.async {
              self.bikeImage = image
            }
        } catch {
            print(error)
        }
    }
  }

  func getfinalRentPrice() {
    let sortedDates = dates.sorted { d1, d2 in
      guard let date1 = Calendar.current.date(from: d1),
            let date2 = Calendar.current.date(from: d2) else { return false }
      return date1 < date2
    }
    guard let startDate = sortedDates.first,
          let endDate = sortedDates.last else { return }
    let formatedStartDate = "\(startDate.year!)-\(startDate.month!)-\(startDate.day!)"
    let formatedEndDate = "\(endDate.year!)-\(endDate.month!)-\(endDate.day!)"
    let monthInitialsStartDate = monthInitialsFromInt(month: startDate.month!)
    let monthInitialsEndDate = monthInitialsFromInt(month: endDate.month!)

    selectedStartDate = "\(monthInitialsStartDate)/\(startDate.day!)"
    selectedEndDate = "\(monthInitialsEndDate)/\(endDate.day!)"


    NetworkManager.getFinalRentPrice(for: bike.id,
                                     user: Int(Constants.userId)!,
                                     startDate: formatedStartDate,
                                     endDate: formatedEndDate) { response in
      guard let response = response else { return }
      self.rentFee = response.fee
      self.rentTotal = response.totalAmount
      self.rentValue = response.rentAmount
    }
  }

  func finalizeBooking() {
    let sortedDates = dates.sorted { d1, d2 in
      guard let date1 = Calendar.current.date(from: d1),
            let date2 = Calendar.current.date(from: d2) else { return false }
      return date1 < date2
    }
    guard let startDate = sortedDates.first,
          let endDate = sortedDates.last else { return }
    let formatedStartDate = "\(startDate.year!)-\(startDate.month!)-\(startDate.day!)"
    let formatedEndDate = "\(endDate.year!)-\(endDate.month!)-\(endDate.day!)"

    NetworkManager.finalizeBikeRent(for: bike.id,
                                     user: Int(Constants.userId)!,
                                     startDate: formatedStartDate,
                                     endDate: formatedEndDate) { response in
      self.bookingFinalized = response
    }
  }

  func goToHomePage() {
    bookingFinalized = false
    goToHomeTap = true
    
  }

  private func monthInitialsFromInt(month: Int) -> String {
    var monthInitial = ""
    switch month {
      case 1:
        monthInitial = "Jan"
      case 2:
        monthInitial = "Feb"
      case 3:
        monthInitial = "Mar"
      case 4:
        monthInitial = "Apr"
      case 5:
        monthInitial = "May"
      case 6:
        monthInitial = "Jun"
      case 7:
        monthInitial = "Jul"
      case 8:
        monthInitial = "Aug"
      case 9:
        monthInitial = "Sep"
      case 10:
        monthInitial = "Oct"
      case 11:
        monthInitial = "Nov"
      case 12:
        monthInitial = "Dec"
      default:
        monthInitial = ""
    }
    return monthInitial
  }
}
