import UIKit
import SparrowKit

@main
class AppDelegate: SPAppWindowDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        makeKeyAndVisible(viewController: ViewController(), tint: .systemBlue)
        return true
    }
}

