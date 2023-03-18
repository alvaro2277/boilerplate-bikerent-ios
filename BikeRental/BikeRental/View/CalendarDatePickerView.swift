//
//  CalendarDatePickerView.swift
//  BikeRental
//
//  Created by Alvaro Barros on 17/03/23.
//

import SwiftUI
import Foundation

struct CalendarDatePickerView: View {
  @Environment(\.calendar) var calendar
  @StateObject var viewModel: BookingViewModel
  @State var isHighlighted = true
  @State var wasHighlighted = false

  var screen = UIScreen.main.bounds
  var bounds: Range<Date> {
    let today = Date()
    let lastDateForRange = calendar.date(from: DateComponents(year: 2222, month: 6, day: 16))!
    return today..<lastDateForRange
  }

    var body: some View {
      VStack {
        Spacer().frame(width: screen.width, height: screen.height * 0.2)
          .background(
            Color(.clear)
          )
          .ignoresSafeArea()
        VStack {
          Spacer().frame(height: 30)
          MultiDatePicker("Dates", selection: $viewModel.dates, in: bounds)
            .tint(.white)
            .colorScheme(.dark)
            .fixedSize()
            .onChange(of: viewModel.dates) { _ in
              if viewModel.dates.count == 2 {
                isHighlighted = true
                highlightDateInterval()
              } else if isHighlighted, !wasHighlighted {
                viewModel.dates.removeAll()
                isHighlighted = false
                wasHighlighted = false
              } else {
                wasHighlighted = false
              }
            }
          Spacer().frame(maxHeight: .infinity)
          Button {
            viewModel.getfinalRentPrice()
            viewModel.showCalendar = false
          } label: {
            Text("Select")
              .font(.system(size: 16))
              .foregroundColor(.black)
              .fontWeight(.bold)
              .frame(width: 327, height: 60)
              .background(Color(uiColor: .mainYellow))
          }
          .cornerRadius(20)
          Spacer().frame(height: 50)
        }
        .frame(width: screen.width, height: screen.height * 0.8)
        .background(
          Color(uiColor: .mainBlue)
        )
        .cornerRadius(30)
      }
      .background(
        Color(.black).opacity(0.5)
      )
    }

  private func highlightDateInterval() {
    let sortedDates = viewModel.dates.sorted { d1, d2 in
      guard let date1 = calendar.date(from: d1),
            let date2 = calendar.date(from: d2) else { return false }
      return date1 > date2
    }
    guard let startDate = calendar.date(from: sortedDates[1]),
          let endDate = calendar.date(from: sortedDates[0]) else { return }
    let rangeOfDates = Date.dates(from: startDate, to: endDate)
    var markedComponents: Set<DateComponents> = []
    if rangeOfDates.count > 2 {
      rangeOfDates.forEach { date in
        let dateComp = Calendar.current.dateComponents([.calendar, .era, .year, .month, .day], from: date)
        markedComponents.insert(dateComp)
      }
      viewModel.dates = markedComponents
      wasHighlighted = true
    }
  }
}

struct CalendarDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
      CalendarDatePickerView(viewModel: BookingViewModel(bike: .testBike))
    }
}
