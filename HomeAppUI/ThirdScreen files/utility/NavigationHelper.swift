import UIKit

extension UIViewController {
    func goToDeviceDetail(title: String, subtitle: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let thirdVC = storyboard.instantiateViewController(withIdentifier: "ThirdScreenViewController") as? ThirdScreenViewController {
            thirdVC.deviceTitle = title
            thirdVC.deviceSubtitle = subtitle
            self.navigationController?.pushViewController(thirdVC, animated: true)
        }
    }
}
