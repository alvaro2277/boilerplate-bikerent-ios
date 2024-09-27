//
//  BookingCompletionView.swift
//  BikeRental
//
//  Created by Alvaro Barros on 17/03/23.
//

import SwiftUI

struct BookingCompletionView: View {
  @Environment(\.dismiss) var dismiss
  @StateObject var viewModel: BookingViewModel
  var screen = UIScreen.main.bounds

    var body: some View {
      ZStack {
        VStack {
          Text("Thank you!")
            .font(.system(size: 24))
            .fontWeight(.bold)
          Spacer().frame(maxHeight: 20)
          Text("Your bike is booked.")
            .font(.system(size: 16))
          Spacer().frame(height: 40)
          Image(uiImage: viewModel.bikeImage ?? UIImage(named: "defaultBikeImage")!)
            .resizable()
            .frame(width: 185, height: 105)
          Spacer().frame(height: 20)
          Text(viewModel.bike.name)
            .font(.system(size: 16))
            .fontWeight(.bold)
          Spacer().frame(height: 10)
          Text(viewModel.bike.type)
            .font(.system(size: 12))
            .padding()
            .frame(minWidth: 128, maxHeight: 26)
            .background(
              RoundedRectangle(cornerRadius: 20)
                .fill(Color(uiColor: .mainYellow))
            )
          Group {
            Spacer().frame(maxHeight: 20)
            Button{
              viewModel.goToHomePage()
            } label: {
              Text("Go to Home Page")
                .foregroundColor(.white)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .frame(width: 289, height: 60)
                .background(
                  Color(uiColor: .mainBlue)
                )
            }
            .cornerRadius(20)
            Spacer().frame(maxHeight: 20)
          }
        }
        .frame(width: screen.width * 0.87, height: screen.height * 0.55)
        .background()
        .cornerRadius(20)
      }
      .frame(width: screen.width, height: screen.height)
      .background(
        Color(.black).opacity(0.5)
      )
    }
}

struct BookingCompletionView_Previews: PreviewProvider {
    static var previews: some View {
      BookingCompletionView(viewModel: BookingViewModel(bike: .testBike))
    }
}
