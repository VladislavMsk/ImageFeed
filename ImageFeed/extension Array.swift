import Foundation
extension Array {
    func withReplaced(itemAt index: Int, newValue: Element) -> [Element] {
        var newArray = self
        if index >= 0 && index < newArray.count {
            newArray[index] = newValue
        }
        return newArray
    }
}
