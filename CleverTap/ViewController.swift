

import UIKit
import CleverTapSDK

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: Tap Function to store Product Viewed Event on Clevertap Dashboard
    
    @IBAction func storeProductViewedEvent(_ sender: Any) {
        
        let props = [
            "Product ID": 1,
            "Product Image": "https://d35fo82fjcw0y8.cloudfront.net/2018/07/26020307/customer-success-clevertap.jpg ",
            "Product Name": "CleverTap"
        ] as [String : Any]

        CleverTap.sharedInstance()?.recordEvent("Product Viewed", withProps: props)
        
        
        let dict = [
            "Email" : "rameshwargupta4444@gmail.com"
        ] as [String : Any]

        CleverTap.sharedInstance()?.profilePush(dict)
    }
    
  


}

