// The MIT License (MIT)
// Copyright © 2021 Ivan Vorobei (hello@ivanvorobei.by)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import SparrowKit
import NativeUIKit
import SPPageController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var controllers: [UIViewController] = []
        
        for index in 0...9 {
            let controller = UIViewController()
            controller.view.backgroundColor = UIColor.systemColorfulColors.randomElement()!
            let navigationController = NativeNavigationController(rootViewController: controller)
            let toolBarView = NativeLargeActionToolBarView()
            toolBarView.actionButton.setTitle("Action Button")
            toolBarView.footerLabel.text = "Here footer which attach to bottom. You shoud see it correctly if layout margins and safe area set correctly as well. Index of page is \(index)."
            navigationController.mimicrateToolBarView = toolBarView
            // For save margins from page controller.
            navigationController.view.preservesSuperviewLayoutMargins = true
            controllers.append(navigationController)
        }

        let pageController = SPPageController(childControllers: controllers, system: .page)
        
        // Example of manage layout margins.
        //pageController.view.layoutMargins = .init(horizontal: 50, vertical: 0)
        present(pageController, animated: true, completion: nil)
    }
}
