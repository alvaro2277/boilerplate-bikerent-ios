//
//  BookingView.swift
//  BikeRental
//
//  Created by Alvaro Barros on 16/03/23.
//

import SwiftUI

struct BookingView: View {
  @Environment(\.dismiss) var dismiss
  @StateObject var viewModel: BookingViewModel
    var body: some View {
      ZStack {
        VStack {
          headerView(viewModel: viewModel)
          Spacer().frame(height: 20)
          bikeDetailCardView(viewModel: viewModel)
          Spacer().frame(height: 20)
          bookingCalendarView(viewModel: viewModel)
          Spacer().frame(height: 50)
          BottomView(viewModel: viewModel)
          Spacer().frame(maxHeight: .infinity)
          buttonView(viewModel: viewModel)
          Spacer().frame(height: 30)
        }
        if viewModel.bookingFinalized {
            BookingCompletionView(viewModel: viewModel)
        }
      }
      .sheet(isPresented: $viewModel.showCalendar) {
        CalendarDatePickerView(viewModel: viewModel)
          .background(BackgroundClearView())
      }
      .onChange(of: viewModel.goToHomeTap) { newValue in
        if newValue {
          dismiss()
        }
      }
    }
}

struct bookingCalendarView: View {
  @StateObject var viewModel: BookingViewModel
  var body: some View {
    Text("Select date and time")
      .font(.system(size: 24))
      .fontWeight(.bold)
      .offset(x: -45)
      .padding(.trailing)
    Spacer().frame(height: 25)
    HStack {
      Image("calendarIcon")
      Spacer().frame(width: 15)
      Text("From \(viewModel.selectedStartDate) to \(viewModel.selectedEndDate)")
        .font(.system(size: 18))
      Spacer().frame(width: 70)
    }.overlay(
      RoundedRectangle(cornerRadius: 30)
        .stroke(Color(uiColor: UIColor.appLightGray), lineWidth: 1)
        .frame(width:327, height: 56)
    )
    .padding(.trailing)
    .onTapGesture {
      withAnimation {
        viewModel.showCalendar = true
      }
    }
  }
}

struct bikeDetailCardView: View {
  @StateObject var viewModel: BookingViewModel
  var body: some View {
    HStack {
      Spacer().frame(width: 10)
      Image(uiImage: viewModel.bikeImage ?? UIImage(named: "defaultBikeImage")!)
        .resizable()
        .frame(width: 100, height: 56)
      Spacer().frame(width: 10)
      VStack {
        Spacer().frame(height: 10)
        Text(viewModel.bike.name)
          .lineLimit(2)
          .font(.system(size: 18))
          .fontWeight(.bold)
        Text(viewModel.bike.type)
          .font(.system(size: 12))
          .padding()
          .frame(minWidth: 128, maxHeight: 26)
          .background(
            RoundedRectangle(cornerRadius: 20)
              .fill(Color(uiColor: .mainYellow))
          )
          .offset(x:-10, y: -10)
        Text("**\(viewModel.bike.rate) €**/Day")
          .font(.system(size: 18))
          .offset(x: -30, y: -10)
      }
      Spacer().frame(width: 15)
    }.overlay(
      RoundedRectangle(cornerRadius: 30)
        .stroke(Color(uiColor: UIColor.appLightGray), lineWidth: 1)
        .frame(width:327, height: 120)
    )
    .padding(.trailing)
  }
}

struct headerView: View {
  @Environment(\.dismiss) var dismiss
  @StateObject var viewModel: BookingViewModel
  var body: some View {
    HStack {
      Image("menuIcon")
        .renderingMode(.template)
        .frame(width: 26.0, height: 16.0)
        .foregroundColor(.black)
      Spacer()
        .frame(width: 210)
      Text("Manhattan")
        .font(.custom("Mont", size: 14))
      Image("locationIcon")
        .renderingMode(.template)
        .frame(width: 13.33, height: 16.67)

    }
    .padding(.trailing)
    Spacer().frame(height: 40)
    HStack {
        Image("arrowIcon")
          .frame(width: 6, height: 12)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color(uiColor: UIColor.appLightGray), lineWidth: 1)
              .frame(width: 52, height: 52)
          )
          .onTapGesture {
            dismiss()
          }
      Spacer()
        .frame(width: 46)
      Text("Booking")
        .font(.custom("Mont", size: 34))
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
      Spacer().frame(width: 117)
    }
    .padding(.trailing)
  }
}

struct BottomView: View {
  @StateObject var viewModel: BookingViewModel
  var body: some View {
    VStack {
      HStack {
        Text("Booking Overview")
           .font(.system(size: 16))
           .fontWeight(.bold)
        Spacer().frame(width: 180)
      }
      .padding(.trailing)
      Spacer().frame(height: 10)
      Spacer()
        .frame(width: 335, height: 2)
        .background(
          Color(uiColor: .appLightGray)
        )
      Spacer().frame(height: 10)
      HStack {
        Spacer().frame(width: 30)
        Text("Subtotal")
          .font(.system(size: 14))
        Image("infoIcon")
        Spacer().frame(maxWidth: .infinity)
        Text("\(viewModel.rentValue, specifier: "%.2f") €")
          .font(.system(size: 14))
        Spacer().frame(width: 30)
      }
      Spacer().frame(height: 10)
      HStack {
        Spacer().frame(width: 30)
        Text("Service Fee")
          .font(.system(size: 14))
        Image("infoIcon")
        Spacer().frame(maxWidth: .infinity)
        Text("\(viewModel.rentFee, specifier: "%.2f") €")
          .font(.system(size: 14))
        Spacer().frame(width: 30)
      }
      Spacer().frame(height: 20)
      HStack {
        Spacer().frame(width: 30)
        Text("Total")
          .font(.system(size: 16))
          .fontWeight(.bold)
        Spacer().frame(maxWidth: .infinity)
        Text("\(viewModel.rentTotal, specifier: "%.2f") €")
          .font(.system(size: 24))
          .fontWeight(.bold)
        Spacer().frame(width: 30)
      }
    }
  }
}

struct buttonView: View {
  @StateObject var viewModel: BookingViewModel
  var body: some View {
    Button {
      viewModel.finalizeBooking()
    } label: {
      Text("Add to booking")
        .font(.system(size: 16))
        .foregroundColor(.white)
        .fontWeight(.bold)
        .frame(width: 327, height: 60)
        .background(
          Color(uiColor: .mainBlue)
        )
    }
    .cornerRadius(20)
    .padding(.trailing)
  }
}

struct BackgroundClearView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .clear
    }
    return view
  }

  func updateUIView(_ uiView: UIView, context: Context) {}
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
      BookingView(viewModel: BookingViewModel(bike: .testBike))
    }
}
