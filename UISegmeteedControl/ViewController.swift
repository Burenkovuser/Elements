//
//  ViewController.swift
//  UISegmeteedControl
//
//  Created by Vasilii on 13/09/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var uiElements = ["UISegmentedControll",
                      "UILabel",
                      "UISlider",
                      "UITextField",
                      "UIButton",
                      "UIDataPicker"]
    
    var selectedElement: String?
    
    @IBOutlet weak var segmetedControl: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.value = 0.5
        
        label.text = String(slider.value)
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmetedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
        choiceUIElements()
        createToolBar()
    }
    
    private func hideAllElements() {
        segmetedControl.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        doneButton.isHidden = true
        datePicker.isHidden = true
    }
    
    private func choiceUIElements() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        textField.inputView = elementPicker // по тапу вызываем пикервью
        
        //Costamization
        elementPicker.backgroundColor = .brown
    }
    
    private func createToolBar(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true) //размещаем кнопку в тулбаре
        toolbar.isUserInteractionEnabled = true // позволяем пользователю взаимодействовать с этим элементом
        
        textField.inputAccessoryView = toolbar // встраиваем тулбар ввиде надстройки над клавиатурой (пикер вью)
        
        //Costamization
        toolbar.tintColor = .white
        toolbar.barTintColor = .brown
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true) // скрываем клавиатуру(пикер вью)
    }

    @IBAction func choiseSegment(_ sender: UISegmentedControl) {
        
        label.isHidden = false
        
        switch segmetedControl.selectedSegmentIndex {
        case 0:
            label.text = "The first segmet is selected"
            label.textColor = .red
        case 1:
            label.text = "The second segmet is selected"
            label.textColor = .blue
        case 2:
            label.text = "The third segmet is selected"
            label.textColor = .green
        default:
            print("Sothing wrong!")
        }
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(sender.value)
        
        let bacgrandColor = self.view.backgroundColor
        self.view.backgroundColor = bacgrandColor?.withAlphaComponent(CGFloat(sender.value))
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        
        guard textField.text?.isEmpty == false else { return }
        
        if let _ = Double(textField.text!) {
            
            let alert = UIAlertController(title: "Wrong format", message: "Please enter your name", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
            
            
        } else {
            label.text = textField.text
            textField.text = nil
        }
    }
    
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let dateValue = dateFormatter.string(from: sender.date)
        label.text = dateValue
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        segmetedControl.isHidden = !segmetedControl.isHidden
        label.isHidden = !label.isHidden
        slider.isHidden = !slider.isHidden
        textField.isHidden = !textField.isHidden
        doneButton.isHidden = !doneButton.isHidden
        datePicker.isHidden = !datePicker.isHidden
        
        if sender.isOn {
            switchLabel.text = "Отобразить все элементы"
        } else {
            switchLabel.text = "Скрыть все элемнеты"
        }
    }
    
    // если редактирование закончилось, клавиатура должна уйти с экрана
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedElement = uiElements[row]
        textField.text = selectedElement
        
        switch row {
        case 0:
            hideAllElements()
            segmetedControl.isHidden = false
        case 1:
            hideAllElements()
            label.isHidden = false
        case 2:
            hideAllElements()
            slider.isHidden = false
        case 3:
            hideAllElements()
        case 4:
            hideAllElements()
            doneButton.isHidden = false
        case 5:
            hideAllElements()
            datePicker.isHidden = false
        default:
            hideAllElements()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        
        pickerViewLabel.textColor = .white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDCothicNeo-Regular", size: 23)
        pickerViewLabel.text = uiElements[row]
        
        return pickerViewLabel
    }
}

