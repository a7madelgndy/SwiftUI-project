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
                    Image(hour.condition.text)
                        .font(.largeTitle)
                    Text("\(String(format: "%.0f", hour.tempC))°C")
                        .frame(width: 100, alignment: .trailing)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}
