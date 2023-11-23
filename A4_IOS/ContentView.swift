import SwiftUI
import CoreLocation

class LocationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?

    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else { return }
        userLocation = location
    }
}

struct ContentView: View {
    @StateObject private var array: DataArray = DataArray(dataschemas: DataSchema.DataPreview)
    @StateObject private var locationDelegate = LocationDelegate()
    @State private var isSheetPresented = false
    @State private var weatherData: WeatherData?

    var body: some View {
        NavigationView {
            VStack {
                if let location = locationDelegate.userLocation {
                    if let cityName = weatherData?.name {
                        Text("Ville : \(cityName)")
                    } else {
                        Text("Nom de la ville non disponible")
                    }
                    if let mainWeather = weatherData?.weather.first?.main {
                        Text("Météo principale : \(mainWeather)")
                        Text("Température : \(temperatureInCelsius) °C")
                    } else {
                        Text("Données météo non disponibles")
                    }
                } else {
                    Text("Coordonnées non disponibles")
                }

                List {
                    ForEach(array.dataschemas.indices, id: \.self) { index in
                        NavigationLink(destination: DataDetailScreen(data: array.dataschemas[index])) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Date: \(formattedDate(for: array.dataschemas[index].date))")
                                    Text("Début Kilomètre: \(array.dataschemas[index].start_kilometre)")
                                    Text("Fin Kilomètre: \(array.dataschemas[index].end_kilometre)")
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteRow)
                }
            }
            .onChange(of: locationDelegate.userLocation?.latitude, { oldValue, newValue in
                fetchWeather()
            })
            .navigationBarItems(trailing:
                Button(action: {
                    isSheetPresented = true
                }) {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }
                .sheet(isPresented: $isSheetPresented) {
                    NewDataScreen(onAddData: { newData in
                        array.dataschemas.append(newData)
                    })
                }
            )
            .navigationBarItems(trailing:
                NavigationLink(destination: GetMeteo()) {
                    Image(systemName: "cloud.circle")
                        .imageScale(.large)
                }
            )
            .navigationBarTitle("Historique", displayMode: .inline)
        }
    }

    private func deleteRow(at offsets: IndexSet) {
        array.dataschemas.remove(atOffsets: offsets)
    }

    private func formattedDate(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: date)
    }

    private func fetchWeather() {
        guard let latitude = locationDelegate.userLocation?.latitude,
              let longitude = locationDelegate.userLocation?.longitude else {
            return
        }

        let apiKey = "a32a825225d19883c0b3eb8e44dd36a1"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"

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
                        self.weatherData = decodedData
                    }
                } catch {
                    print("Erreur lors de la conversion des données JSON: \(error.localizedDescription)")
                }
            }
        }

        task.resume()
    }

    var temperatureInCelsius: String {
        guard let kelvinTemperature = weatherData?.main.temp else {
            return "N/A"
        }

        let celsiusTemperature = kelvinTemperature - 273.15
        return String(format: "%.0f", celsiusTemperature)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
