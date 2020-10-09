//
//  ViewController.swift
//  UIkitComponents
//
//  Created by ousmane diouf on 9/25/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var visitSwitch: UISwitch!
    @IBOutlet weak var visitTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightSliderText: UILabel!
    @IBOutlet weak var puppyCount: UIStepper!
    @IBOutlet weak var puppyCountLabel: UILabel!
//MARK: -Class Variable
    private var datePicker = UIDatePicker()
    private var heightPicker = UIPickerView()
    var heightPickerdata = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dog Profile"
        setupVisit()
        setupHeight()
        setupSlider()
        setupStepper()
        self.datePicker.addTarget(self, action: #selector(setDate), for: .valueChanged)

    }

//MARK: -Helper Function

    private func setupVisit() {
        self.visitTextField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    private func setupHeight() {
        self.heightTextField.inputView = heightPicker
        heightPicker.delegate = self
    }
    private func keyboardWillShow() {}

    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    func setupStepper() {
        self.puppyCount.addTarget(self, action: #selector(puppyCountValue), for: .valueChanged)
    }
    func setupSlider() {
            self.weightSlider.value = 50
            self.weightSlider.maximumValue = 170
            self.weightSlider.minimumValue = 10
            self.weightSlider.addTarget(self, action: #selector(updateWeightValue), for: .valueChanged)
        }
    @objc func puppyCountValue() {
        if puppyCount.value == 1 {
            self.puppyCountLabel.text = " \(Int(self.puppyCount.value)) Puppy"
        } else {
        self.puppyCountLabel.text = " \(Int(self.puppyCount.value)) Puppies"
        }
    }

    @objc func updateWeightValue() {
            self.weightSliderText.text = "\(Int(self.weightSlider.value)) lbs"
        }
//MARK:- Action Function
    @objc func setDate() {
        let calendar =  Calendar.current
        let components =  calendar.dateComponents([.day, .month, .year], from: self.datePicker.date)

        if let day = components.day,
           let month = components.month,
           let year = components.year {
            self.visitTextField.text = "\(month)/\(day)/\(year)"
        }
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        heightTextField.text = heightPickerdata[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return heightPickerdata[row]
    }
}
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        heightPickerdata.count
    }
}
