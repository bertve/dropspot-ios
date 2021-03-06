//
//  ContentFloatingPanelViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 07/01/2021.
//

import UIKit
import MaterialComponents

class ContentFloatingPanelViewController: FormValidatingKeyboardHandlingViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var flagIndicator: UIImageView!
    @IBOutlet var spotToggle: UISwitch!
    @IBOutlet var spotName: MDCOutlinedTextField!
    @IBOutlet var parkCategory: MDCOutlinedTextField!
    @IBOutlet var street: MDCOutlinedTextField!
    @IBOutlet var houseNumber: MDCOutlinedTextField!
    @IBOutlet var city: MDCOutlinedTextField!
    @IBOutlet var postalCode: MDCOutlinedTextField!
    @IBOutlet var state: MDCOutlinedTextField!
    @IBOutlet var country: MDCOutlinedTextField!
    @IBOutlet var addBtn: MDCButton!
    @IBOutlet var contentStack: UIStackView!
    @IBOutlet var fieldsStack: UIStackView!
    @IBOutlet var feeSlider: UISlider!
    @IBOutlet var damageLbl: UILabel!
    @IBOutlet var feeValLbl: UILabel!
    
    // park spot elements
    private var parkSpotUIElements : [UIView] = []
    private var fieldshelper: [UITextField]?
    
    // picker helpers
    var parkCatList : [ParkCategory] = ParkCategory.allCases
    private var selectedParkCategory: ParkCategory?
    
    // delegate
    var delegate: ContentFloatingPanelDelegate?
    
    // coordinate
    var latitude: Double? {
        didSet{
            if latitude != nil {
                flagIndicator.image = UIImage(named: "flagOutlined")
            } else {
                flagIndicator.image = UIImage(named: "flag")
            }
        }
    }
    
    var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
        // set picker
        setupPickerView()
        
        // set slider
        feeValLbl.text = feeSlider.value.formatAsEuroCurrency()
        
        // setup formvalidater and keyboardhandling
        self.formValidator = AddStreetSpotFormValidator(spotName: spotName)
        self.fields = [spotName]
        fieldshelper = [spotName, parkCategory, street, houseNumber, city, postalCode, state, country]
        
        self.formConfirmingButton = addBtn
        
        // set parkspot ui elements
        parkSpotUIElements = [feeSlider, damageLbl, feeValLbl, parkCategory, street, houseNumber, street, houseNumber, city, postalCode, state, country]
        
    }
    
    private func applyTheme(){
        Theme.applyThemeToTextField(spotName)
        Theme.applyThemeToTextField(street)
        Theme.applyThemeToTextField(houseNumber)
        Theme.applyThemeToTextField(city)
        Theme.applyThemeToTextField(postalCode)
        Theme.applyThemeToTextField(state)
        Theme.applyThemeToTextField(country)
        Theme.applyThemeToTextField(parkCategory)
        Theme.applyThemeToButton(addBtn)
        
        // floating label
        spotName.label.text = "Name"
        street.label.text = "Street"
        houseNumber.label.text = "House Number"
        city.label.text = "City"
        postalCode.label.text = "Postal Code"
        state.label.text = "State"
        country.label.text = "Country"
        parkCategory.label.text = "Park Category"
    }
    

    @IBAction func spotToggleChangedVal(_ sender: UISwitch) {
        if sender.isOn {
            activateParkMode()
        } else {
            activateStreetMode()
        }
    }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        if let del = delegate {
            del.exitFPCClicked()
        }
    }
    
    @IBAction func sliderValChanged(_ sender: UISlider) {
        feeValLbl.text = sender.value.formatAsEuroCurrency()
    }
    
    private func activateStreetMode(){
        self.switchFields()
        self.formValidator = AddStreetSpotFormValidator(spotName: spotName)
        parkSpotUIElements.forEach { el in
            el.visibility = .gone
        }
    }
    
    private func activateParkMode(){
        self.switchFields()
        self.formValidator = AddParkSpotFormValidator(spotName: spotName, parkCategory: parkCategory, street: street, houseNumber: houseNumber, city: city, postalCode: postalCode, state: state, country: country)
        super.updateFormConfirmingButtonState()
        parkSpotUIElements.forEach { el in
            el.visibility = .visible
        }
    }
    
    private func switchFields(){
        let switchHelper = self.fieldshelper!
        self.fieldshelper = self.fields
        self.fields = switchHelper
    }
    
    // MARK: picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return parkCatList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return parkCatList[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedParkCategory = parkCatList[row]
        parkCategory.text = selectedParkCategory?.rawValue
    }
    
    func setupPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        parkCategory.inputView = pickerView
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.collapsePicker))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        parkCategory.inputAccessoryView = toolBar
    }

    @objc func collapsePicker() {
          view.endEditing(true)
    }
    
    // MARK: add spot
    @IBAction func addBtnPressed(_ sender: Any) {
        if let lat = latitude,
           let long = longitude {
            spotToggle.isOn ? addParkSpot(lat: lat,long: long) : addStreetSpot(lat: lat, long: long)
        } else {
            showSnackBar(message: "Mark the map to indicate your new spot location!")
        }
    }
    
    private func addStreetSpot(lat: Double,long: Double){
        if let del = delegate {
            del.addStreetSpot(requestModel: AddStreetSpotRequestModel(name: spotName.text!.trim(), latitude: lat, longitude: long))
        }
    }
    
    private func addParkSpot(lat: Double,long: Double ){
        if let del = delegate {
            del.addParkSpot(requestModel: AddParkSpotRequestModel(name: spotName.text!.trim(),
                                                               latitude: lat,
                                                               longitude: long,
                                                               entranceFee: feeSlider.value,
                                                               parkCategory: selectedParkCategory!,
                                                               street: street.text!.trim(),
                                                               houseNumber: houseNumber.text!.trim(),
                                                               postalCode: postalCode.text!.trim(),
                                                               city: city.text!.trim(),
                                                               state: state.text!.trim(),
                                                               country: country.text!.trim())
            )
        }
    }
    
    func clearFields() {
        self.fields.forEach{ field in
            field.text = ""
        }
        self.feeSlider.value = 0
        selectedParkCategory = nil
    }
    
}
