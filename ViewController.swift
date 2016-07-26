//
//  ViewController.swift
//  Weather App
//
//  Created by Xiyuan Chen on 2016-06-21.
//  Copyright © 2016 Simon Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var wasSuccessful = false
        
        let text = cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + text + "/forecasts/latest")
        
        if let url = attemptedUrl {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let webArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if (webArray?.count > 1) {
                    // print (webArray![1])
                    
                    let weatherArray = webArray![1].componentsSeparatedByString("</span>")
                    
                    print(weatherArray[0])
                    
                    if (weatherArray.count > 1 ) {
                        
                         wasSuccessful = true
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            self.resultLabel.text = weatherSummary
                            
                        })
                    }
                }
            }
            
            if (wasSuccessful == false) {
                
                self.resultLabel.text = " Couldn't find the weather for that city -- please try again"
            }
            
        }
        
            task.resume()
        }

        else {
            
            self.resultLabel.text = " Couldn't find the weather for that city -- please try again"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

