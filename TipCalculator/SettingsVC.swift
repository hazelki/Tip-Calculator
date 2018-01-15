
import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var segmentButton: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        if let tipValue =  UserDefaults.standard.object(forKey: "tip"){
           let tipPercentage = Double(tipValue as! Int)
           // calculateTotalAmount(self.tipTF.text!)
            if tipPercentage == 10{
                segmentButton.selectedSegmentIndex = 0
            }else if tipPercentage == 15{
                segmentButton.selectedSegmentIndex = 1
                
            }else if tipPercentage == 20{
                segmentButton.selectedSegmentIndex = 2
            }
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func segmentButtonTapped(_ sender: Any) {
        
        if segmentButton.selectedSegmentIndex == 0{
            UserDefaults.standard.set(10, forKey: "tip")
        }else if segmentButton.selectedSegmentIndex == 1{
            UserDefaults.standard.set(15, forKey: "tip")
        }else{
            UserDefaults.standard.set(20, forKey: "tip")
        }
        UserDefaults.standard.synchronize()
    }
    
}
