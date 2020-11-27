//
//  secondSceen.swift
//  BMI
//
//  Created by Noura alsulayfih on 3/20/1442 AH.
//  Copyright © 1442 AH Noura alsulayfih. All rights reserved.
//

import UIKit

class secondSceen: UIViewController {
    
    //MARK:- Attributes.
    var Age: Int!
    var Wieght: Double!
    var Measure: String!
    var Hight:Int!
    var Gender:String!
    var hightsRangeCM:[Int]!
    var hightsRangeM:[Double]!
    
    //MARK:- @IBOutlet.
    @IBOutlet var measuresSegmentedControl: UISegmentedControl!
    @IBOutlet var hightPickerView: UIPickerView!
    @IBOutlet var hight: NSLayoutConstraint!
    @IBOutlet var hightLabel: UILabel!
    
    
    //MARK:- Functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        createArrayWithRange(min: 120, max: 200,minD: 1.2,maxD: 2.0)
        pickerViewConfiguration()
        

    }
    
    func pickerViewConfiguration(){
        hightPickerView.selectRow(hightsRangeCM.count/2, inComponent: 0, animated: true)
        hightPickerView.frame = CGRect(x: 0, y: 0, width: 40, height: view.frame.height)
        //make it streching.

    }
    
    func createArrayWithRange(min: Int, max: Int ,minD:Double, maxD:Double){
        hightsRangeCM = [Int](min...max)
        hightsRangeM = Array(stride(from: minD, through: maxD, by: 0.1))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondToThird"{
            let vc = segue.destination as! thirdScreen
            vc.Age = Age
            vc.Mass = Wieght
            vc.Measure = Measure
            vc.Hight = Hight
            vc.Gender = Gender
        }
    }
}

//MARK:- PickerViewDelegate Extension.
extension secondSceen:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        let label = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 35)
        label.frame = CGRect(x: 0, y: 0, width: 40, height: 35)
        label.textAlignment = .center
        label.textColor = .systemGray6
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "\(hightsRangeCM[row])"
        view.addSubview(label)
        if (hightsRangeCM[row]+5) % 2 == 0{
            hight.constant = CGFloat(integerLiteral: hightsRangeCM[row]+300)
        }

        hightLabel.text = "\(hightsRangeCM[row])"
        Hight = hightsRangeCM[row]
        return view
    }
    
    
}
//MARK:- PickerViewDataSource Ectension.
extension secondSceen:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hightsRangeCM.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if measuresSegmentedControl.selectedSegmentIndex == 0 {
            return "\(hightsRangeCM[row])"
        }
        return "\(hightsRangeM[row])"
    }
}
    

    
    
    
    




