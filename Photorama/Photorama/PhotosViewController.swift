import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionsView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath = collectionsView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected Segue Identifier.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionsView.dataSource = photoDataSource
        
        collectionsView.delegate = self
        
        
        store.fetchInterestingPhotos{
            (photoResult) -> Void in
            
            switch photoResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching interesting photos \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionsView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImage(for: photo) { (result) -> Void in
            
            guard let photoIndex = self.photoDataSource.photos.index(of: photo),
                case let .success(image) = result else {
                    return
            }
            
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            if let cell = self.collectionsView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
            
        }
        
    }
}
