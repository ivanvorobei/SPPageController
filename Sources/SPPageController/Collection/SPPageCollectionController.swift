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

class SPPageCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Init
    
    init(childControllers: [UIViewController]) {
        self.childControllers = childControllers
        let layout = SPPageCollectionViewFlowLayout()
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        
        for controller in childControllers {
            self.addChild(controller)
            controller.didMove(toParent: self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    /**
     SPPageController: Scroll to controller by `index`.
     
     - parameter index: Index of scrolling controller.
     - parameter animated: Scroll to controller animated or not.
     */
    func safeScrollTo(index: Int, animated: Bool) {
        if index > (childControllers.count - 1) {
            // Don't safe index.
            return
        }
        collectionView.scrollToItem(at: .init(row: index, section: .zero), at: .centeredVertically, animated: animated)
    }
    
    // MARK: - Layout
    
    private var cellLayoutMargins: UIEdgeInsets { collectionView.layoutMargins }
    private var layout: SPPageCollectionViewFlowLayout { collectionViewLayout as! SPPageCollectionViewFlowLayout }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.visibleCells.forEach({ $0.contentView.layoutMargins = cellLayoutMargins })
        
        let newItemSize = collectionView.frame.size
        if layout.itemSize != newItemSize {
            layout.itemSize = collectionView.frame.size
            layout.invalidateLayout()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childControllers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SPPageCollectionViewCell.id, for: indexPath) as! SPPageCollectionViewCell
        let controller = childControllers[indexPath.row]
        cell.setViewController(controller)
        cell.contentView.layoutMargins = cellLayoutMargins
        return cell
    }
    
    // MARK: - Internal
    
    /**
     SPPageController: All controllers, which show in pages.
     */
    private var childControllers: [UIViewController]
}
