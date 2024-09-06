//
//  Casting Day.swift
//  SwiftUIProject
//
//  Created by Ahmed El Gndy on 06/09/2024.
//

import SwiftUI

struct HourlyForecastView: View {
    let forecastDay: Forecastday
    
    var body: some View {
        VStack {
            Text("Hourly Forecast for \(forecastDay.date)")
                .font(.headline)
                .padding()
            
            List(forecastDay.hour, id: \.time) { hour in
                HStack {
                    Text(hour.time)
                        .frame(width: 100, alignment: .leading)
                    let baseURL = "https:"
                    let iconPath = hour.condition.icon
                    let fullURLString = baseURL + iconPath
                    AsyncImage(url: URL(string:fullURLString)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    
                            case .failure:
                                Image(systemName: "exclamationmark.icloud")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    Text("\(String(format: "%.0f", hour.tempC))°C")
                        .frame(width: 100, alignment: .trailing)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}
