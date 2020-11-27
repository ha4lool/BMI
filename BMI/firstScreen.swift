//
//  firstScreen.swift
//  BMI
//
//  Created by Noura alsulayfih on 3/19/1442 AH.
//  Copyright © 1442 AH Noura alsulayfih. All rights reserved.
//

import UIKit

class firstScreen: UIViewController {
    
    //MARK:- Attributes.
    var Age: Int!
    var Weight: Double!
    var Measure: String!
    var Gender:String!
    var rotaion:CGFloat!
    var ageRange:[Int]!
    var wieghtsRange:[Int]!

    //MARK:- @IBOutlet.
    @IBOutlet var femaleGes: UITapGestureRecognizer!
    @IBOutlet var maleGes: UITapGestureRecognizer!
    @IBOutlet var weighingScaleView: UIView!
    @IBOutlet var wieght: UILabel!
    @IBOutlet var femaleCheck: UIImageView!
    @IBOutlet var maleCheck: UIImageView!
    @IBOutlet var agePickerView: UIPickerView!
    @IBOutlet var wieghts: UIPickerView!
    @IBOutlet var measureTextField: UITextField!
    
    //MARK:- Funcions.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        measureTextField.text = ""
        createArrayWithRange(minA: 10, maxA: 90,minW:40, maxW:140)
        MakePickerViewHorozintal(pickerView: agePickerView,selected: ageRange ,width: view.frame.width + 200,x: -100)
        MakePickerViewHorozintal(pickerView: wieghts, selected: wieghtsRange, width: weighingScaleView.frame.width,x:-(weighingScaleView.frame.width/2)-5)
        weighingScaleView.layer.borderWidth = 5
        weighingScaleView.layer.borderColor = .init(genericGrayGamma2_2Gray:
            2.3, alpha: 0.5)

    }
    
    func createArrayWithRange(minA: Int, maxA: Int,minW:Int, maxW:Int){
        ageRange = [Int](minA...maxA)
        wieghtsRange = [Int](minW...maxW)
    }
    
    func MakePickerViewHorozintal(pickerView:UIPickerView,selected:[Int],width : CGFloat,x:CGFloat){
        rotaion = -90 * (.pi/180)
        let y = pickerView.frame.origin.y
        pickerView.transform = CGAffineTransform(rotationAngle: rotaion)
        pickerView.frame = CGRect(x: x, y: y, width: view.frame.width + 200, height: 70)
        pickerView.selectRow(ageRange.count/4, inComponent: 0, animated: true)
    }
    func showAlert(alertTitle:String, alertMessage:String, actionTitle:String, style:UIAlertAction.Style){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: style, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! secondSceen
        vc.Age = Age
        vc.Wieght = Weight
        vc.Measure = Measure
        (maleCheck.isHidden == false && femaleCheck.isHidden == true) ? (vc.Gender = "Male") : (vc.Gender = "Female")
    }
    
    //MARK: - @IBActions
    
    @IBAction func nextButton(_ sender: Any) {
        
        if(maleCheck.isHidden == true && femaleCheck.isHidden == true){
            showAlert(alertTitle: "Warning", alertMessage: "please select your gender", actionTitle: "Ok", style: .cancel)
        }
        
        
        //measurement Sanitization:
        Measure = measureTextField.text!.lowercased().trimmingCharacters(in: .whitespaces)
        
        //measurement validation
        if(Measure == ""){
            showAlert(alertTitle: "Error", alertMessage: "please enter the measure of your wieght", actionTitle: "OK", style: .destructive)
        }
        else if(Measure.elementsEqual("kg") || Measure.elementsEqual("kilograms") || Measure.elementsEqual("kilogram")){
            Measure = "Kg"
        }
        else if(Measure.elementsEqual("ib") || Measure.elementsEqual("pounds") || Measure.elementsEqual("pound")){
            Measure = "Ib"
        }
        else{
            showAlert(alertTitle: "Error", alertMessage: "Invalid inputs please try again", actionTitle: "OK", style: .destructive)
            
        }
    }
    
    @IBAction func malePressed(_ sender: Any) {
        //select and unselect
        if(maleCheck.isHidden == true && femaleCheck.isHidden == true) {
            maleCheck.isHidden = false
            Gender = "Male"
        }else{
            maleCheck.isHidden = true
        }
        
        if(maleCheck.isHidden == true && femaleCheck.isHidden == false){
            showAlert(alertTitle: "Error", alertMessage: "please un select the female option in order to select Male", actionTitle: "Ok", style: .destructive)
        }
    }
    
    @IBAction func femalePressed(_ sender: Any) {
        //select and unselect
        if(femaleCheck.isHidden == true && maleCheck.isHidden == true) {
            femaleCheck.isHidden = false
            Gender = "Female"
        }else{
            femaleCheck.isHidden = true
        }
        
        if(femaleCheck.isHidden == true && maleCheck.isHidden == false){
                   showAlert(alertTitle: "Error", alertMessage: "please un select the male option in order to select Female", actionTitle: "Ok", style: .destructive)
               }
    }
}
    //MARK:- PickerViewDelegate Extension
extension firstScreen:UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if pickerView.tag == 1 {
            return 70
        }
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if pickerView.tag == 1 {
            return 70
        }
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        let label = UILabel()
        
        if(pickerView.tag == 1){
            view.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
            label.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
            label.textAlignment = .center
            label.text = "\(ageRange[row])"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 20)
            label.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180 ))
            view.addSubview(label)
            if(pickerView.selectedRow(inComponent: 0) == row){
                let color = UIColor.systemPink
                label.attributedText = NSAttributedString(string: "\(ageRange[row])", attributes: [.foregroundColor: color,.font: UIFont.systemFont(ofSize: 40)])
            }
            Age = pickerView.selectedRow(inComponent: 0) + 10
            return view
        }
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        label.textAlignment = .center
        label.text = "\(wieghtsRange[row])"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180 ))
        view.addSubview(label)
        wieght.text = label.text
        wieght.font = UIFont.systemFont(ofSize: 30)
        Weight = Double(wieghtsRange[row])
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
    }
    
}

    //MARK:- PickerViewDataSource Extension
extension firstScreen:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
           return ageRange.count
        }
        return wieghtsRange.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1 ){
            return "\(ageRange[row])"
        }
        return "\(wieghtsRange[row])"
    }
}

extension firstScreen:UITextFieldDelegate{
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    
}


