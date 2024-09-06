//
//  Networking.swift
//  SwiftUIProject
//
//  Created by Ahmed El Gndy on 26/08/2024.
//
import Foundation


struct NetworkService {
    static func fetchedUsers(completion: @escaping (WeatherResponse?) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=2302bfbbc5c742f19fc235029242508&q=30.0715495,31.0215953&days=3&aqi=yes&alerts=no"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(weatherResponse)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil)
            }
        }

        task.resume()
    }
}
var weatherResponseFromAPI: WeatherResponse?

func fetchWeatherData() {
    NetworkService.fetchedUsers { response in
        if let response = response {
            print("Weather data fetched successfully")
            print("Location: \(response.location.name), Temp: \(response.current.tempC)°C")
        } else {
            print("Failed to fetch weather data")
        }
    }
}

