//
//  thirdScreen.swift
//  BMI
//
//  Created by Noura alsulayfih on 3/20/1442 AH.
//  Copyright © 1442 AH Noura alsulayfih. All rights reserved.
//

import UIKit

class thirdScreen: UIViewController {

    //MARK:- Attributes.
    var Gender:String!
    var Mass:Double!
    var Measure: String!
    var Hight:Int!
    var Age: Int!
    
    
    //MARK:-IBOutlets.
    @IBOutlet var BMIResult: UILabel!
    @IBOutlet var BMIState: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var massLabel: UILabel!
    @IBOutlet var genderImage: UIImageView!
    @IBOutlet var hightLabel: UILabel!
    @IBOutlet var measuerment: UILabel!
    
    
    
    
    //MARK:- Functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateBMI()
        configuerDetails()

        

    }
    
    func calculateBMI(){
        if(Measure == "Ib"){
            Mass = ceil(Double(Mass) / 2.2046226218)
            print(Mass!)
        }
        let hightInMS:Double = pow(Double(Hight)/100.0, 2)
        let BMI:Double = Double(Mass)/hightInMS
        //state remains
        if(BMI<18.5){BMIState.text = "Under weight"}
        if(BMI>=18.5 && BMI<=24.9){BMIState.text = "Normal weight"}
        if(BMI>=25 && BMI<=29.9){BMIState.text = "over wieght"}
        if(BMI>=30 && BMI<=34.9){BMIState.text = "Obesity class I"}
        if(BMI>=35 && BMI<=39.9){BMIState.text = "Obesity class II"}
        if(BMI>=40){BMIState.text = "Obesity class III"}
        let valueInString = "\(BMI)".split(separator: ".")
        BMIResult.text = "\(Int(BMI))"+"."+"\(valueInString[1].first ?? "0")"
        if(Measure == "Kg"){
            measuerment.text = "Kilograms"
            massLabel.text = "\(Int(Mass!))"
        }else{
            measuerment.text = "Pounds"
            massLabel.text = "\(Int(Mass! * 2.2046226218))"
        }
    }
    
    func configuerDetails(){
        ageLabel.text = "\(Age!)"
        hightLabel.text = "\(Hight!)"
        print(Int(Mass!))
        (Gender == "Female") ? (genderImage.image = UIImage(named: "female")) : (genderImage.image = UIImage(named: "male"))
    }

}
