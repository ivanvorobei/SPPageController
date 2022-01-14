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

class SPPageNativeController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, SPPageControllerInterface {
    
    // MARK: - Init
    
    init(childControllers: [UIViewController]) {
        self.childControllers = childControllers
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        guard let firstController = self.childControllers.first else { return }
        setViewControllers([firstController], direction: SPPageNativeController.direction, animated: false, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        view.layoutMargins = .zero
        view.preservesSuperviewLayoutMargins = true
        view.insetsLayoutMarginsFromSafeArea = false
        
        for view in view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delaysContentTouches = false
                scrollView.preservesSuperviewLayoutMargins = true
            }
        }
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
    }
    
    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let margins = view.layoutMargins
        childControllers.forEach({
            if $0.view.preservesSuperviewLayoutMargins && $0.view.layoutMargins != margins  {
                $0.view.layoutMargins = margins
            }
        })
    }
    
    // MARK: - SPPageControllerInterface
    
    var allowScroll: Bool {
        get { scrollView?.isScrollEnabled ?? false }
        set { scrollView?.isScrollEnabled = newValue }
    }
    
    func safeScrollTo(index: Int, animated: Bool) {
        let controller = childControllers[index]
        setViewControllers([controller], direction: SPPageNativeController.direction, animated: true, completion: nil)
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = childControllers.firstIndex(of: viewController) else { return nil }
        let newIndex = index - 1
        if newIndex < 0 { return nil }
        return childControllers[newIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = childControllers.firstIndex(of: viewController) else { return nil }
        let newIndex = index + 1
        if newIndex > childControllers.count - 1 { return nil }
        return childControllers[newIndex]
    }
    
    // MARK: - Internal
    
    private var childControllers: [UIViewController]
    
    private var scrollView: UIScrollView? {
        view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView
    }
    
    private static var direction: NavigationDirection {
        if UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
            return .forward
        } else {
            return .reverse
        }
    }
}
