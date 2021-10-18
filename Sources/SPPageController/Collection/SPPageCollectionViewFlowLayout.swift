import UIKit

class SPPageCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else { return .zero }
        let center = CGPoint(x: collectionView.contentOffset.x + (collectionView.frame.width / 2), y: (collectionView.frame.height / 2))
        guard let indexPath = collectionView.indexPathForItem(at: center) else { return .zero }
        let attributes =  collectionView.layoutAttributesForItem(at: indexPath)
        let newOriginForOldIndex = attributes?.frame.origin
        return newOriginForOldIndex ?? proposedContentOffset
    }
}
