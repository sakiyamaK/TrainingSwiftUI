//
//  InputLocationView.swift
//  WWDC
//
//  Created by sakiyamaK on 2025/10/31.
//

import SwiftUI
import SwiftData
import MapKit

@Model
final class WeatherModel: Identifiable, Hashable, Decodable {
    var id: Int
    var main: String
    var desc: String
    var icon: String

    enum CodCodeKey: String, CodingKey {
        case id, main, description, icon
    }


    init(id: Int, main: String, desc: String, icon: String) {
        self.id = id
        self.main = main
        self.desc = desc
        self.icon = icon
    }

    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodCodeKey.self)
        id = try values.decode(Int.self, forKey: .id)
        main = try values.decode(String.self, forKey: .main)
        desc = try values.decode(String.self, forKey: .description)
        icon = try values.decode(String.self, forKey: .icon)
    }
}

@Observable
final class LocationViewModel {
    let OPEN_WEATHER_API_KEY = "09bfd38045ee170fe9a77af8449842a2"

    private var locations: [CLLocation] = []

    var processItems: [WeatherModel] = []
    private(set) var errorMessage: String? = nil

    func fetchWeathers() async {
        for location in locations {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(OPEN_WEATHER_API_KEY)&units=metric"

            guard let url = URL(string: urlString) else {
                self.errorMessage = "URLが無効です"
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                processItems.append(weather)
            } catch {
                self.errorMessage = "天気情報の取得に失敗しました: \(error.localizedDescription)"
            }

        }
    }

    func add(lat: Double, lon: Double) {
        locations.append(CLLocation(latitude: lat, longitude: lon))
    }
}

struct InputLocationView: View {
    @State var viewModel: LocationViewModel

    var body: some View {
        LazyVStack {
            ForEach($viewModel.processItems, id: \.id) { $item in
                HStack {
                    Text(item.main)
                    Spacer()
                    Text(item.desc)
                }
            }
        }
        .task {
            viewModel.add(lat: 35.574208132477104, lon: 139.71951867229689)
//            await viewModel.fetchWeathers()
        }
    }
}

#Preview {
    InputLocationView(viewModel: LocationViewModel())
}
