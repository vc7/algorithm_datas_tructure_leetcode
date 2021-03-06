import Foundation

class Solution {
    func displayTable(_ orders: [[String]]) -> [[String]] {
        var foodItems = Set<String>()
        // [tableNumber: [foodName: numberOfDishes]]
        var tableDishes = [String: [String: Int]]()
        
        // O(n) | Gathering and grouping the data
        for order in orders { 
            let tableNumber = order[1]
            let foodItem = order[2]
            
            // Set the food item
            foodItems.insert(order[2])
            
            // Pump up the number of the current foodItem

            // Get current table, create one if not exist
            var table = tableDishes[tableNumber] ?? [String: Int]()
            // Get the dish count of the food item, use 0 if not exist
            let dishCount = (table[foodItem] ?? 0) + 1
            
            // Assigning back to the hash table
            table[foodItem] = dishCount
            tableDishes[tableNumber] = table
        }
        
        // O(flogf) | Convert the food items set to an array and sort it
        let sortedFoodItems = Array(foodItems).sorted(by: <)

        // O(1) | Prepare the result array
        var result: [[String]] = [["Table"] + sortedFoodItems]
        
        // O(tlogt) | Sort the table numbers
        let sortedTableNumbers = tableDishes.keys.sorted { Int($0)! < Int($1)! }
        
        // O(t * f) | Composing every row by sorted table numbers
        for tableNumber in sortedTableNumbers {
            var content = [tableNumber]
            guard let dishes = tableDishes[tableNumber] else { continue }
            
            for foodName in sortedFoodItems {
                content.append("\(dishes[foodName] ?? 0)")
            }
            result.append(content)
        }
        
        return result
    }
}
