import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    // MARK: Outlets
    @IBOutlet var nameField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var takePicture: UIBarButtonItem!
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else{
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func clearImage(_ sender: UIButton) {
        if imageStore.image(forKey: item.itemKey) != nil {
            imageStore.deleteImage(forKey: item.itemKey)
            imageView.image = nil
        }
    }
    
    // MARK: Variables
    var item: Item!
    let numberFormatter = NumberFormatter()
    var imageStore: ImageStore!
    
    // MARK: Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imageStore.setImage(image, forKey: item.itemKey)
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        super.viewDidAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        let key = item.itemKey
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
}
