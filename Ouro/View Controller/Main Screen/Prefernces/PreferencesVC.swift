//
//  PreferencesVC.swift
//  Ouro
//
//  Created by PC on 22/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import Firebase

struct Prefernces
{
    var name : String
    var discription : String
    init(name:String,discription:String) {
        self.name = name
        self.discription = discription
    }
}
class PreferencesVC: BaseViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tblprefernces: UITableView!
    
    //MARK:- Variables
        var arrPreferences = [Prefernces]()
    var travelDistance:Int = 5
    var pricerange: String? = "$"
    var isVagetarian: String = "False"
    var isFamilarfrenches: String = "False"
    var isnewexperiance: String = "False"
    var islocalFamilar: String = "False"
    var isquickandeasy: String = "False"
    var ref: DatabaseReference!
    var defaultdataDictionary = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpnavigation()
        
        let value = defaultdataDictionary["distance"] as? Int ?? 0
        if value > 0 {
            travelDistance = value
        }
        arrPreferences = [Prefernces(name: "vegetarian", discription: "All Food type vagetarian friendly,avoiding food related to steak,cheaken and pork"),
                          Prefernces(name: "Familar Frenches", discription: "All Food type vagetarian friendly,avoiding food related to steak,cheaken and pork"),
                          Prefernces(name: "new Experience", discription: "we will suggest places in which you haven't checked in for new flavors"),
                          Prefernces(name: "Local & Familar", discription: "Feel Flavour that make you feel at home,in a Quite and familiar Environment"),
                          Prefernces(name: "Quick And Easy", discription: "if u have only small break to have food select this option")]
        
        let dict = UserDefaults.standard.dictionary(forKey: "PreferencesData") ?? [:]
        if dict.isEmpty {
            defaultdataDictionary = ["distance":travelDistance,
            "PricePreference":pricerange,
            "isVagetarian":isVagetarian,
            "isFamilarfrenches":isFamilarfrenches,
            "isnewexperiance":isnewexperiance,
            "islocalFamilar":islocalFamilar,
            "isquickandeasy":isquickandeasy]
            travelDistance = 5
        } else {
            defaultdataDictionary = dict
            travelDistance = dict["distance"] as? Int ?? 0
        }
        setUptableview()
        SetupNavigatiionshadow()
        
        
    }
    //MARK:- SetUp Navigation
    func setUpnavigation()
    {
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        setLeftClose(img: "close")
        SetNavigationTitle(Navname: "Prefernces")
        var RightBarDoneItem = UIBarButtonItem()
        RightBarDoneItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(btnDoneClicked))
        RightBarDoneItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = RightBarDoneItem
    }
   
    @objc func btnDoneClicked()  {
        UserDefaults.standard.set(defaultdataDictionary, forKey: "PreferencesData")
        dismiss(animated: true, completion: nil)
        print(UserDefaults.standard.dictionary(forKey: "PreferencesData"))
    }
    
    //MARK:- Setup TableView
    func setUptableview()
    {
        self.tblprefernces.register(UINib(nibName: "PreferencesTabelCell", bundle: nil), forCellReuseIdentifier: "PreferencesTabelCell")
        self.tblprefernces.register(UINib(nibName: "PreferencesSwitchTabelCell", bundle: nil), forCellReuseIdentifier: "PreferencesSwitchTabelCell")
        self.tblprefernces.delegate = self
        self.tblprefernces.dataSource = self
    }
    
    //MARK:- Increse Miles
    @objc func IncreseMiles(_sender : UIButton)
    {
        travelDistance = travelDistance + 1
        let cell = tblprefernces.cellForRow(at: IndexPath(row: _sender.tag, section: 0)) as! PreferencesTabelCell
        cell.lblMiles.text = "\(travelDistance) Miles"
        cell.lblfinalMiles.text = "\(travelDistance) Miles"
        defaultdataDictionary["distance"] = travelDistance
       
        print(travelDistance)

    }
    
    //MARK:- Decrese Miles
    @objc func DecreseMiles(_sender : UIButton)
    {
        travelDistance = travelDistance - 1
          let cell = tblprefernces.cellForRow(at: IndexPath(row: _sender.tag, section: 0)) as! PreferencesTabelCell
        cell.lblMiles.text = "\(travelDistance) Miles"
        defaultdataDictionary["distance"] = travelDistance
        print(travelDistance)
        cell.lblfinalMiles.text = "\(travelDistance) Miles"
    }
    
    @objc func GetSegmentindexValue()
    {
        let cell = tblprefernces.cellForRow(at: IndexPath(row: 0, section: 0)) as! PreferencesTabelCell
        pricerange = cell.segmentedControl.titleForSegment(at: cell.segmentedControl.selectedSegmentIndex) ?? ""
        print(pricerange ?? "")
        switch cell.segmentedControl.selectedSegmentIndex {
       case 0:
        defaultdataDictionary["PricePreference"] = "$"
       case 1:
        defaultdataDictionary["PricePreference"] = "$$"
       case 2:
        defaultdataDictionary["PricePreference"] = "$$$"
       case 3:
        defaultdataDictionary["PricePreference"] = "$$$$"
       default:
        defaultdataDictionary["PricePreference"] = "$"
       }
    }

    @objc func switchIsChanged(myswitch : UISwitch)
    {
        let cell = tblprefernces.cellForRow(at: IndexPath(row: myswitch.tag, section: 1)) as! PreferencesSwitchTabelCell
        if cell.preferncesswitch.isOn{
            if myswitch.tag == 0
            {
                isVagetarian = "true"
                defaultdataDictionary["isVagetarian"] = isVagetarian
            }
            if myswitch.tag == 1
            {
                isFamilarfrenches = "true"
                defaultdataDictionary["isFamilarfrenches"] = isFamilarfrenches
            }
            if myswitch.tag == 2
            {
                isnewexperiance = "true"
                defaultdataDictionary["isnewexperiance"] = isnewexperiance
            }
            if myswitch.tag == 3
            {
                islocalFamilar = "true"
                defaultdataDictionary["islocalFamilar"] = islocalFamilar
            }
            if myswitch.tag == 4
            {
                isquickandeasy = "true"
                defaultdataDictionary["isquickandeasy"] = isquickandeasy
            }
        }
        else
        {
            if myswitch.tag == 0
            {
                isVagetarian = "false"
                defaultdataDictionary["isVagetarian"] = isVagetarian
            }
            if myswitch.tag == 1
            {
                isFamilarfrenches = "false"
                defaultdataDictionary["isFamilarfrenches"] = isFamilarfrenches
            }
            if myswitch.tag == 2
            {
                isnewexperiance = "false"
                defaultdataDictionary["isnewexperiance"] = isnewexperiance
            }
            if myswitch.tag == 3
            {
                islocalFamilar = "false"
                defaultdataDictionary["islocalFamilar"] = islocalFamilar

            }
            if myswitch.tag == 4
            {
                isquickandeasy = "false"
                defaultdataDictionary["isquickandeasy"] = isquickandeasy
            }
        }
    }
}
//MARK:- Tableview Delegate And Datasource Method
extension PreferencesVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return arrPreferences.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreferencesTabelCell", for: indexPath) as! PreferencesTabelCell
            
            if UserDefaults.standard.dictionary(forKey: "PreferencesData") == nil{
                cell.lblMiles.text =  (self.defaultdataDictionary["distance"] as? Int ?? 0).description + " Miles"
                cell.lblfinalMiles.text = (self.defaultdataDictionary["distance"] as? Int ?? 0).description + " Miles"
            }else{
                cell.lblMiles.text =  (self.defaultdataDictionary["distance"] as? Int ?? 0).description + " Miles"
                cell.lblfinalMiles.text = (self.defaultdataDictionary["distance"] as? Int ?? 0).description + " Miles"
            }
           
            pricerange = defaultdataDictionary["PricePreference"] as? String ?? ""
            cell.segmentedControl.selectedSegmentIndex = (pricerange ?? "$").count - 1

            cell.btnDecreseMiles.addTarget(self, action: #selector(DecreseMiles(_sender:)), for: .touchUpInside)
            cell.btnIncreseMiles.addTarget(self, action: #selector(IncreseMiles(_sender:)), for: .touchUpInside)
            pricerange = cell.segmentedControl.titleForSegment(at: cell.segmentedControl.selectedSegmentIndex) ?? ""
            cell.segmentedControl.addTarget(self, action: #selector(GetSegmentindexValue), for: .valueChanged)
           
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreferencesSwitchTabelCell", for: indexPath) as! PreferencesSwitchTabelCell
            cell.lblPreferncesName.text = arrPreferences[indexPath.row].name
            cell.lblPreferncesDiscriontion.text = arrPreferences[indexPath.row].discription
            cell.preferncesswitch.tag = indexPath.row
            if cell.lblPreferncesName.text == "vegetarian"
            {
                defaultdataDictionary["isVagetarian"] as? String ?? nil == "true" ? cell.preferncesswitch.setOn(true, animated: true) : cell.preferncesswitch.setOn(false, animated: true)
            }
            if cell.lblPreferncesName.text == "Familar Frenches"
            {
                defaultdataDictionary["isFamilarfrenches"] as? String ?? nil == "true" ? cell.preferncesswitch.setOn(true, animated: true) : cell.preferncesswitch.setOn(false, animated: true)
            }
            if cell.lblPreferncesName.text == "new Experience"
            {
                 defaultdataDictionary["isnewexperiance"] as? String ?? nil == "true" ? cell.preferncesswitch.setOn(true, animated: true) : cell.preferncesswitch.setOn(false, animated: true)
            }
            if cell.lblPreferncesName.text == "Local & Familar"
            {
                 defaultdataDictionary["islocalFamilar"] as? String ?? nil == "true" ? cell.preferncesswitch.setOn(true, animated: true) : cell.preferncesswitch.setOn(false, animated: true)
            }
            if cell.lblPreferncesName.text == "Quick And Easy"
            {
                 defaultdataDictionary["isquickandeasy"] as? String ?? nil == "true" ? cell.preferncesswitch.setOn(true, animated: true) : cell.preferncesswitch.setOn(false, animated: true)
            }
            cell.preferncesswitch.addTarget(self, action: #selector(switchIsChanged(myswitch:)), for: .valueChanged)
            return cell
        }
  
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 390.0
        }
        else
        {
            return 100.0
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 390.0
        }
        else
        {
            return 100.0
        }
    }
    
}

