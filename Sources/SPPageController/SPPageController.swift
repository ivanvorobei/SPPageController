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

/**
 SPPageController: Mimicrate to native `UIPageViewController`.
 
 Each page is new controller, it can be even navigation controller.
 Support layout margins, paging and scroll by index.
 */
open class SPPageController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIAdaptivePresentationControllerDelegate {
    
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
        get { collectionView.isScrollEnabled }
        set { collectionView.isScrollEnabled = newValue }
    }
    
    // MARK: - Init
    
    public init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        
        for controller in viewControllers {
            self.addChild(controller)
            controller.didMove(toParent: self)
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        presentationController?.delegate = self
        collectionView.delaysContentTouches = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layoutMargins = .zero
        collectionView.preservesSuperviewLayoutMargins = true
        collectionView.insetsLayoutMarginsFromSafeArea = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SPPageCollectionViewCell.self, forCellWithReuseIdentifier: SPPageCollectionViewCell.id)
    }
    
    // MARK: - Actions
    
    open func safeScrollTo(index: Int, animated: Bool) {
        if index > (viewControllers.count - 1) {
            // Don't safe index.
            return
        }
        collectionView.scrollToItem(at: .init(row: index, section: .zero), at: .centeredVertically, animated: animated)
    }
    
    // MARK: - Layout
    
    private var cellLayoutMargins: UIEdgeInsets {
        collectionView.layoutMargins
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.visibleCells.forEach({ $0.contentView.layoutMargins = cellLayoutMargins })
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        /*
         Use it code for safe index when device rotated.
         */
        guard let collectionView = collectionView else { return }
        let offset = collectionView.contentOffset
        let width = collectionView.bounds.size.width
        let index = round(offset.x / width)
        let newOffset = CGPoint(x: index * size.width, y: offset.y)
        coordinator.animate(alongsideTransition: { (context) in
            collectionView.setContentOffset(newOffset, animated: true)
        }, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource
    
    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SPPageCollectionViewCell.id, for: indexPath) as! SPPageCollectionViewCell
        let controller = viewControllers[indexPath.row]
        cell.setViewController(controller)
        cell.contentView.layoutMargins = cellLayoutMargins
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    // MARK: - Internal
    
    /**
     SPPageController: All controllers, which show in pages.
     */
    private var viewControllers: [UIViewController]
    
    // MARK: - UIAdaptivePresentationControllerDelegate
    
    public func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return allowDismissWithGester
    }
}

