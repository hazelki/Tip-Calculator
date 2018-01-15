
import UIKit

class ViewController: BaseVC,UITextFieldDelegate{

    @IBOutlet weak var finalAmountLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var tipTextField: UITextField!
    
    @IBOutlet weak var segmentButton: UISegmentedControl!
    var tipPercentage :Double = 10
    var lastRefreshedTime:Date?
    override func viewDidLoad() {
        super.viewDidLoad()
        addTap()
        self.tipTextField.delegate = self
        self.title = "Tip Calculator"
        initialise()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),name: .UIApplicationDidBecomeActive,object: nil)
        
        // self
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func initialise(){
        self.tipTextField.text = "$ "
        self.totalAmountLabel.text = ""
        
    }
    @objc func applicationDidBecomeActive(){
        checkTime()
    }
    
    func checkTime(){
        if lastRefreshedTime == nil{
            lastRefreshedTime = Date()
        }else{
            let date2 = Date()
            let timeBetweenDates = date2.timeIntervalSince(lastRefreshedTime!)
            //var distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
            if timeBetweenDates > 600{ //ten minutes seconds 600 seconds
                initialise()
                tipTextField.becomeFirstResponder()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTime()
        if let tipValue =   UserDefaults.standard.object(forKey: "tip"){
            tipPercentage = Double(tipValue as! Int)
            calculateTotalAmount(self.tipTextField.text!)
            if tipPercentage == 10{
                segmentButton.selectedSegmentIndex = 0
            }else if tipPercentage == 15{
            self.segmentButton.selectedSegmentIndex = 1
                
            }else if tipPercentage == 20{
               self.segmentButton.selectedSegmentIndex = 2
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tipTextField.becomeFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        let lengthOfText = txtAfterUpdate.characters.count
        
        if(textField == self.tipTextField){
            
            if(lengthOfText == 1){
                return false
            }
            else
            {
                calculateTotalAmount(txtAfterUpdate)
                return true
            }
            
        }
            
        return true

    }
    
    
    func calculateTotalAmount(_ texting:String)
{
        if((texting.characters.count) <= 2)
        {
            self.totalAmountLabel.text = ""
            return
        }
        let index = texting.index((texting.startIndex), offsetBy: 2)
       // var amount = self.tipTextField.text?.substring(fromIndex:index);
        
      let amount =   texting.substring(from: index)
        
        var amountInDouble = Double(amount)
        let amountInDouble1  = (amountInDouble! * tipPercentage )/100
        amountInDouble = (amountInDouble! + amountInDouble1)
        
        self.totalAmountLabel.text = String(describing: amountInDouble!)
    }
    
    
    @IBAction func barbuttonItemTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func segmentButtonTapped(_ sender: Any) {
    if(segmentButton.selectedSegmentIndex == 0){
            tipPercentage = 10;
        }
        else if (segmentButton.selectedSegmentIndex == 1)
        {
            tipPercentage = 15
        }
        else if (segmentButton.selectedSegmentIndex == 2)
        {
            tipPercentage = 20
        }
        calculateTotalAmount(self.tipTextField.text!)
    }
}

