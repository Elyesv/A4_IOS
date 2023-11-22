import Foundation
import SwiftUI

struct WeatherData: Codable {
    var weather: [Weather]
    var main: Main
    
    struct Weather: Codable {
        var main: String
    }
    
    struct Main: Codable {
        var temp: Double
    }
}

struct GetMeteo: View {
    
    @State private var departCity: String = ""
    @State private var meteoData: WeatherData?
    
    var temperatureInCelsius: String {
        guard let kelvinTemperature = meteoData?.main.temp else {
            return "N/A"
        }
        
        let celsiusTemperature = kelvinTemperature - 273.15
        return String(format: "%.0f", celsiusTemperature)
    }
    
    var body: some View {
        Form{
            Section {
                TextField("Votre ville de départ", text: $departCity)
            }
            
            Section{
                Button(action: {
                    fetchWeather()
                }, label: {
                    Text("Rechercher")
                })
            }
            
            if let mainWeather = meteoData?.weather.first?.main {
                Section {
                    Text("Météo principale : \(mainWeather)")
                    Text("Température : \(temperatureInCelsius) °C")
                }
            }
        }
    }
    
    func fetchWeather() {
        guard !departCity.isEmpty else {
            return
        }
        
        let apiKey = "a32a825225d19883c0b3eb8e44dd36a1"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(departCity)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("URL invalide")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur lors de la récupération des données: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Réponse serveur invalide")
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        self.meteoData = decodedData
                    }
                } catch {
                    print("Erreur lors de la conversion des données JSON: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
}

#Preview {
    GetMeteo()
}
