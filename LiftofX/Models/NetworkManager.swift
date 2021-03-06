//
//  NetworkManager.swift
//  LiftofX
//
//  Created by SyberPoiint on 5/17/2022.
//

import Foundation

class NetworkManager: ObservableObject{
    
    @Published var mission = [Mission]()
    
    func fetchData(){
        if let url = URL(string: "https://api.spacexdata.com/v5/launches/upcoming"){
            
            let session = URLSession(configuration: .default)
            let tasks = session.dataTask(with: url) { data, response, error in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
//                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let results = try decoder.decode( Array<Mission>.self, from: safeData)
                            
//                            let links = try response.nestedContainer(keyedBy: CodingKeys.self, forKey: .links)
                            
                            DispatchQueue.main.async {
                                self.mission = results
                                print(results)
                            }
                        } catch {
                            print ("ERROR", error)
                        }
                    }
                }
            }
            tasks.resume()
            
        }
    }
    
    func formatDate(date: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:date)!
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM dd, yyyy, h:mm a"
        return dateFormat.string(from: date)
    }
    
}
