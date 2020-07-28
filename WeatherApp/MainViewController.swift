//
//  MainViewController.swift
//  WeatherApp
//
//  Created by User on 7/25/20.
//  Copyright © 2020 Aidin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var conditionImageLabel: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temparuterLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    var lat = 11.344533
    var lon = 104.33322
    var acrivityIndicator: NVActivityIndicatorView!
    let locationManager = CLLocationManager()
    let gradientClass = Gradient()
    let gradient = CAGradientLayer()
    let weatherInfo = WeatherInfo()

    override func viewDidLoad() {
           super.viewDidLoad()
        
        background.layer.addSublayer(gradient)
        locationFunc()
    }
    
    fileprivate func locationFunc() {
           let indicatorSize: CGFloat = 70
           let indicatorFrame = CGRect(x: (view.frame.width - indicatorSize) / 2, y: (view.frame.width - indicatorSize) / 2, width: indicatorSize, height: indicatorSize)
           acrivityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
           acrivityIndicator.backgroundColor = UIColor.black
           view.addSubview(acrivityIndicator)
           
           locationManager.requestWhenInUseAuthorization()
           
           acrivityIndicator.stopAnimating()
           if CLLocationManager.locationServicesEnabled() {
               locationManager.delegate = self
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.startUpdatingLocation()
           }
       }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations[0]
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            
            weatherInfo.getURL(lat: lat, lon: lon)
            dayLabel.text = weatherInfo.getCurrentDate()
            locationManager.stopUpdatingLocation()
        
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func setWeather(temp: Int, name: String, image: String, mainDescription: String) {
        temparuterLabel.text = "\(temp)"
        conditionLabel.text = mainDescription
        print(description)
        conditionImageLabel.image = UIImage(named: image)
        conditionImageLabel.isHidden = false
        locationLabel.text = name
        let suffix = image.suffix(1)
        if suffix == "n"{
            gradientClass.setNightGradiant(view: self.view, gradient: gradient)
        } else {
            gradientClass.setDayGradient(view: self.view, gradient: gradient)
        }
    }
    
}
