import UIKit

class ItemsViewController: UITableViewController {
    var itemStore = ItemStore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemStore.allItems.count 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if(indexPath.row == itemStore.allItems[indexPath.section].count - 1){
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell2", for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.font = cell.textLabel?.font.withSize(CGFloat(20))
        }
        
        let item = itemStore.allItems[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == itemStore.allItems[indexPath.section].count - 1){
            return CGFloat(44)
        }else{
            return CGFloat(60)
        }
    }
    
    
    
}
