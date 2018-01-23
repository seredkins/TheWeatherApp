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
        citiesWeatherList.append(WeatherForecast(city: "Moscow", weather: Dictionary<String, String>()))
        super.viewDidLoad()
        let session = URLSession.shared
        for cityWeather in citiesWeatherList {
            guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Moscow&unit=metric&lang=ru&APPID=35471c8f32e8bc6e41efe48676d4c84a") else { return }
            let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                guard let httpResponse  = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    error == nil, let data = data else {
                        print("Error")
                        return
                }
                print("DataResponce: \(data)")
            }
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

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
