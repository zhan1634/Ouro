//
//  PreferencesViewController.swift
//  Ouro
//
//  Created by Jack Zhang on 2019-04-28.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {
    
    @IBOutlet var UpDown: UIImageView!
    @IBOutlet weak var PreferencesLabel: UILabel!
    
    // Distance Filter
    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var DistanceDescription: UILabel!
    @IBOutlet weak var DistanceSlider: UISlider!
    
    // Price Filter
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var PriceDescription: UILabel!
    @IBOutlet weak var PriceSlider: UISegmentedControl!
    
    // Vegetarian Filter
    @IBOutlet weak var Vegetarian: UILabel!
    @IBOutlet weak var VegetarianDescription: UILabel!
    @IBOutlet weak var VegetarianToggle: UISwitch!
    
    // Franchise Filter
    @IBOutlet weak var Franchise: UILabel!
    @IBOutlet weak var FranchiseDescription: UILabel!
    @IBOutlet weak var FranchiseToggle: UISwitch!
    
    // New Experience Filter
    @IBOutlet weak var NewExperience: UILabel!
    @IBOutlet weak var NewExperienceDescription: UILabel!
    @IBOutlet weak var NewExperienceToggle: UISwitch!
    
    // Local Filter
    @IBOutlet weak var Local: UILabel!
    @IBOutlet weak var LocalDescription: UILabel!
    @IBOutlet weak var LocalToggle: UISwitch!
    
    // Quick Filter
    @IBOutlet weak var Quick: UILabel!
    @IBOutlet weak var QuickDescription: UILabel!
    @IBOutlet weak var QuickToggle: UISwitch!
    
    // Healthy Filter
    @IBOutlet weak var Healthy: UILabel!
    @IBOutlet weak var HealthyDescription: UILabel!
    @IBOutlet weak var HealthyToggle: UISwitch!
    
    
    var UpDownLabel = String()  {
        didSet{
            UpDown.image = UIImage(named: UpDownLabel)
            }
        }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setparameterconstraints()
        setupstartinglabel()
        UpDown.image = UIImage(named: "Up")
        
    }
    
    @IBAction func DistanceSliderChanged(_ sender: UISlider) {
        UserDefaults.standard.set(Float(sender.value)/1000, forKey: "SearchDistance")
    }
    
    @IBAction func PriceSliderChanged(_ sender: UISlider) {
        UserDefaults.standard.set(String(repeating: "$", count: Int(sender.value)), forKey: "PricePreference")
    }
  
  
  //EDIT: ***************
  @IBAction func priceSegmentChanged(_ sender: Any) {
    switch PriceSlider.selectedSegmentIndex {
    case 0:
      UserDefaults.standard.set("$", forKey: "PricePreference")
    case 1:
       UserDefaults.standard.set("$$", forKey: "PricePreference")
    case 2:
       UserDefaults.standard.set("$$$", forKey: "PricePreference")
    case 3:
       UserDefaults.standard.set("$$$$", forKey: "PricePreference")
    default:
      UserDefaults.standard.set("$", forKey: "PricePreference")
    }
  }
  //END EDIT: ***************
  
  func setupstartinglabel() {
        
        self.view.addSubview(PreferencesLabel)
        self.view.addSubview(UpDown)
        
        PreferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        UpDown.translatesAutoresizingMaskIntoConstraints = false
        
        PreferencesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45).isActive = true
        PreferencesLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        PreferencesLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        UpDown.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        UpDown.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        UpDown.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func setparameterconstraints() {
        
        let LabelArray = [Distance, Price, Vegetarian, Franchise, NewExperience, Local, Quick, Healthy]
        let DescriptionArray = [DistanceDescription, PriceDescription, VegetarianDescription, FranchiseDescription, NewExperienceDescription, LocalDescription, QuickDescription, HealthyDescription]
        let TogglesArray = [DistanceSlider, PriceSlider, VegetarianToggle, FranchiseToggle, NewExperienceToggle, LocalToggle, QuickToggle, HealthyToggle]
        
        let sidebounds = self.view.frame.width * 0.12
        var loopNumber = 0
        let movement = (self.view.frame.height) / 10
        var labelmovementposition: CGFloat
        var descriptionmovementposition: CGFloat
        var togglemovementposition: CGFloat
        
        for input in LabelArray {
            
            if loopNumber < 2 {
                labelmovementposition = 90.0 + CGFloat(loopNumber) * movement * 1.3
            } else {
                labelmovementposition = 155.0 + CGFloat(loopNumber) * movement
            }
            
            if let label = input {
                self.view.addSubview(label)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.font = label.font.withSize(16)
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: labelmovementposition).isActive = true
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidebounds).isActive = true
                label.heightAnchor.constraint(equalToConstant: 30).isActive = true
                label.widthAnchor.constraint(equalToConstant: 170).isActive = true
            }
            
            descriptionmovementposition = labelmovementposition + 10.0
            
            if let description = DescriptionArray[loopNumber] {
                
                self.view.addSubview(description)
                description.translatesAutoresizingMaskIntoConstraints = false
                description.numberOfLines = 2
                description.font = description.font.withSize(12)
                
                if loopNumber < 2 {
                    description.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * sidebounds).isActive = true
                } else {
                    description.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * sidebounds - 70.0).isActive = true
                }
                description.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: descriptionmovementposition).isActive = true
                description.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidebounds).isActive = true
                description.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
            }
            
            togglemovementposition = labelmovementposition + 20
            
            if let toggle = TogglesArray[loopNumber] {
                self.view.addSubview(toggle)
                toggle.translatesAutoresizingMaskIntoConstraints = false
                
                if loopNumber < 2 {
                    toggle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidebounds).isActive = true
                    toggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * sidebounds).isActive = true
                    togglemovementposition = togglemovementposition + 50
                } else {
                    toggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * sidebounds).isActive = true
                    toggle.widthAnchor.constraint(equalToConstant: 60).isActive = true
                }
                toggle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: togglemovementposition).isActive = true
                toggle.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
            
            loopNumber = loopNumber + 1
        }
        
    }
    
}
