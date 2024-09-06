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
                Image("1")
                        .resizable()
                        .ignoresSafeArea()
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
                            
                            let baseURL = "https:"
                            let iconPath = weather.current.condition.icon
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
                                                 let baseURL = "https:"
                                                 let iconPath = forecastday.day.condition.icon
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
                                                 Text("H:\(String(format: "%.0f", forecastday.day.maxtempC))° L:\(String(format: "%.0f", forecastday.day.mintempC))°")
                                                     .frame(width: 130)
                                             }
                                         }
                                     }
                                 }
                             }
                             .padding()
                        VStack {
                            HStack{
                                Spacer()
                                VStack{
                                    Text("Visabilty")
                                   // weather.current.visKM
                                    Text("\(String(format: "%.0f", weather.current.visKM)) Km")
                                }
                                Spacer()
                                VStack{
                                    Text("HUMIDITY")
                                    Text("\(String(format: "%.0f", weather.current.humidity)) %")
                                }
                                Spacer()
                            }
                            .padding(.bottom,40)
                            
                            HStack{
                                Spacer()
                                VStack{
                                    Text("Feelies like")
                                   // weather.current.visKM
                                    Text("\(String(format: "%.0f", weather.current.feelslikeC)) ")
                                }
                                Spacer()
                                VStack{
                                    Text("perssuer")
                                    Text("1,022")
                                }
                                Spacer()
                            }
                            
                        }
       
                         }
                
                     } else {
                         ProgressView("Loading...")
                             .progressViewStyle(CircularProgressViewStyle())
                     }
           
                 }
            .onAppear {
                loadWeather()
                
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
