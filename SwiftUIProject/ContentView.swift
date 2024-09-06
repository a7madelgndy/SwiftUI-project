//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Ahmed El Gndy on 26/08/2024.
//
import SwiftUI


struct ContentView: View {
    @State private var weatherResponse: WeatherResponse?

    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                    .onAppear {
                        loadWeather()
                    }
                
                if let weather = weatherResponse {
                    VStack {
                        VStack {
                            Text(weather.location.name)
                                .font(.system(size: 36))
                                .fontWeight(.bold)
                            
                            Text("\(String(format: "%.0f", weather.current.tempC))°")
                                .font(.system(size: 36))
                                .fontWeight(.bold)
                            
                            Text(weather.current.condition.text)
                                .font(.system(size: 36))
                                .fontWeight(.bold)
                            
                            Text("H:\(String(format: "%.0f", weather.forecast.forecastday[0].day.maxtempC))° L:\(String(format: "%.0f", weather.forecast.forecastday[0].day.mintempC))°")
                                .font(.system(size: 36))
                                .bold()
                            
                        AsyncImage(url: URL(string: weather.current.condition.icon)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                case .failure:
                                    Image(systemName: "exclamationmark.icloud")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                                 Text("3-DAY FORECAST")
                                     .font(.system(size: 20))
                                     
                                 ForEach(weather.forecast.forecastday, id: \.date) { forecastday in
                                     NavigationLink(destination: HourlyForecastView(forecastDay: forecastday)) {
                                         VStack {
                                             Divider()
                                             HStack {
                                                 Text(forecastday.date)
                                                     .frame(width: 130)
                                                 Image(systemName: "cloud.fill")
                                                     .font(.largeTitle)
                                                 Text("H:\(String(format: "%.0f", forecastday.day.maxtempC))° L:\(String(format: "%.0f", forecastday.day.mintempC))°")
                                                     .frame(width: 130)
                                             }
                                         }
                                     }
                                 }
                             }
                             .padding()
                         }
                     } else {
                         ProgressView("Loading...")
                             .progressViewStyle(CircularProgressViewStyle())
                     }
                 }
             }
         }


    private func loadWeather() {
        NetworkService.fetchedUsers { response in
            DispatchQueue.main.async {
                self.weatherResponse = response
            }
        }
    }
}
#Preview {
    ContentView()
}
