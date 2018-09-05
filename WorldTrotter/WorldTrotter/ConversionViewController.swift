import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let calendar = Calendar.current
        let startTimeComponent = DateComponents(calendar: calendar, hour: 8)
        let endTimeComponent   = DateComponents(calendar: calendar, hour: 17, minute: 30)
        
        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)
        let startTime    = calendar.date(byAdding: startTimeComponent, to: startOfToday)!
        let endTime      = calendar.date(byAdding: endTimeComponent, to: startOfToday)!
        
        if startTime <= now && now <= endTime {
            self.view.backgroundColor = UIColor.lightGray
        } else {
            self.view.backgroundColor = randomColor()
        }
    }
    
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionController loaded its view.")
        
        updateCelsiusLabel()
    }
    
    var farenheitValue: Measurement<UnitTemperature>? {
        didSet{
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>?{
        if let farenheitValue = farenheitValue {
             return farenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var return_value = true
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replcementTextHasDecimalSeparator = string.range(of: ",")
        if existingTextHasDecimalSeparator != nil, replcementTextHasDecimalSeparator != nil {
            return_value = false
        }
        
        let alphaSet = NSCharacterSet(charactersIn: "-0123456789.").inverted
        if string.rangeOfCharacter(from: alphaSet) != nil {
            return_value = false
        }
        
        return return_value
    }
    
    func updateCelsiusLabel(){
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "????"
        }
    }
    
    @IBAction func farenheitFieldEditingChanged(_ textField: UITextField){
        if let text = textField.text, let value = Double(text) {
            farenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            farenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
}
