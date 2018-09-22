import UIKit

class ItemStore {
    var allItems = [[Item]]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        if(newItem.valueInDollars < 50){
            allItems[0].append(newItem)
        } else {
            allItems[1].append(newItem)
        }
        
        return newItem
    }
    
    init(){
        allItems.append([])
        allItems.append([])
        for _ in 0..<10 {
            createItem()
        }
        
        allItems[0].append(Item(endRow: true))
        allItems[1].append(Item(endRow: true))
    }
}
