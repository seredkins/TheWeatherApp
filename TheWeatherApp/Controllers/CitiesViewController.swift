//
//  CitiesViewController.swift
//  TheWeatherApp
//
//  Created by theSERG on 23/01/2018.
//  Copyright © 2018 seredkins. All rights reserved.
//

import UIKit

class CitiesViewController: UITableViewController {
    
    var citiesWeatherList = [WeatherForecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl?.addTarget(self, action: #selector(doRequest), for: .valueChanged)
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        searchBar.sizeToFit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addCity(city: "Moscow")
        doRequest()
    }
    
    func addCity(city: String) {
        let forecast = WeatherForecast(name: city)//, weather: Dictionary<String, String>())
        citiesWeatherList.append(forecast)
        
//        let alert = UIAlertController.init(title: city, message: "City added", preferredStyle: .alert)
//        let action = UIAlertAction.init(title: "Ok", style: .default)
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
        
        tableView.reloadData()
    }
    
    @objc func doRequest() {
        let session = URLSession.shared
        for cityWeather in citiesWeatherList {
            guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=\(cityWeather.city.name)&unit=metric&lang=ru&APPID=35471c8f32e8bc6e41efe48676d4c84a") else { return }
            let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                }
                guard let httpResponse  = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    error == nil, let data = data else {
                        print("Error: \(error?.localizedDescription ?? "")")
                        return
                }
                print("DataResponse: \(data)")
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                    let jsonDictionary = json as? [String: Any] else { return }
                
                if let city = jsonDictionary["city"] as? [String: Any], let name = city["name"] as? String {
                    print("name: \(name)")
                }
                
//                guard let weatherForecast = try? JSONDecoder().decode(WeatherForecast.self, from: data) else { return }
//                print("weatherForecast: \(weatherForecast)")
            }
            dataTask.resume()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citiesWeatherList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        let citiesWeather = citiesWeatherList[indexPath.row]
        cell.textLabel?.text = citiesWeather.city.name

        return cell
    }
}

extension CitiesViewController : UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBar: \(searchBar.text ?? "")")
        searchBar.resignFirstResponder()
    }
}
