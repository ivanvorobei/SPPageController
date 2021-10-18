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

open class SPPageController: UIViewController, SPPageControllerInterface {
    
    // MARK: - Data
    
    /**
     SPPageController: Manage if can be dissmiss by gester.
     Call for modal screens only.
     */
    open var allowDismissWithGester: Bool = true
    
    /**
     SPPageController: Allow or disable scroll by pages with gester.
     */
    open var allowScroll: Bool {
        get { (containerController as! SPPageControllerInterface).allowScroll }
        set { (containerController as! SPPageControllerInterface).allowScroll = newValue }
    }
    
    // MARK: - Init
    
    public init(childControllers: [UIViewController], system: SPPageControllerSystem) {
        switch system {
        case .page:
            containerController = SPPageNativeController(childControllers: childControllers)
        case .scroll:
            containerController = SPPageCollectionController(childControllers: childControllers)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        presentationController?.delegate = self
        
        addChild(containerController)
        view.addSubview(containerController.view)
        containerController.didMove(toParent: self)
        
        containerController.view.preservesSuperviewLayoutMargins = true
        containerController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerController.view.topAnchor.constraint(equalTo: view.topAnchor),
            containerController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    
    open func safeScrollTo(index: Int, animated: Bool) {
        (containerController as! SPPageControllerInterface).safeScrollTo(index: index, animated: animated)
    }
    
    // MARK: - Internal
    
    private var containerController: UIViewController
}
