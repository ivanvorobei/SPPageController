// The MIT License (MIT)
// Copyright © 2021 Ivan Vorobei (hello@ivanvorobei.io)
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

class SPPageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Data
    
    static var id: String { return "SPPageCollectionViewCell" }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        insetsLayoutMarginsFromSafeArea = false
        preservesSuperviewLayoutMargins = false
        contentView.insetsLayoutMarginsFromSafeArea = false
        contentView.preservesSuperviewLayoutMargins = false
        contentView.layoutMargins = .zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    // MARK: - Actions
    
    func setViewController(_ controller: UIViewController) {
        guard let view = controller.view else { return }
        let superView = contentView
        superView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superView.topAnchor),
            view.leftAnchor.constraint(equalTo: superView.leftAnchor),
            view.rightAnchor.constraint(equalTo: superView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}


