import UIKit
class SecondViewController: UIViewController {
    @IBAction func back(_ sender: Any){
        self.presentingViewController?.dismiss(animated: true)
    }
    @IBAction func back2(_ sender: Any){
        _=self.navigationController?.popViewController(animated: true)
    }
}
