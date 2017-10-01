import Foundation

class MergeSort {
    
// MARK: Dissassembling Symbols
    
    func split (_ array: Array<Int>) -> Array<Array<Int>> {
        guard array.count > 1 else { return [array] }
        var output = [array.enumerated().filter { $0.offset < array.count/2 }.map{ $0.element },
                      array.enumerated().filter { $0.offset >= array.count/2 }.map{ $0.element }]
        if array.count % 2 != 0 { output.append([output[1].removeLast()]) }
        return output
    }
    
    func dissassemble (_ array: Array<Int>) -> Array<Array<Int>> {
        // The number of iterations required to break down array = ceil(log_2(l)); where l = length of input array
        //      - Special Case: l < 3; In this case ceil(log_2(l)) = 1 where it should be 2. Therefore l > 2
        if array.count < 3 { return [[array[0]], [array[1]]] }
        
        var output = [array]
        
        for _ in 1...(Int(ceil(log2(Double(array.count))))) {
            var t = output
            t.removeAll()
            for h in 0..<output.count {
                let parts = split(output[h])
                for part in parts {
                    t.append(part)
                }
            }
            output = t
        }
        return output
    }
    
    
// MARK: Assembling Symbols
    
    // Pre-Condition: The passed arrays themselves must be sorted
    func merge (_ left: Array<Int>, _ right: Array<Int>) -> Array<Int> {
        var output = Array<Int>(), a1 = left, a2 = right
        while output.count < left.count + right.count {
            var lowest = 0
            if a1.isEmpty { lowest = a2.removeFirst() }
            else if a2.isEmpty { lowest = a1.removeFirst()}
            else { lowest = (a1[0] < a2[0]) ? a1.removeFirst() : a2.removeFirst() }
            output.append(lowest)
        }
        return output
    }
    
    func assemble (_ array: Array<Array<Int>>) -> Array<Int> {
        var output = array
        while output.count > 1 {
            var t = Array<Array<Int>>()
            for h in stride(from: 0, through: (output.count % 2 != 0) ? output.count - 1 : output.count, by: 2) {
                if h > output.count - 1 { break }
                else if h + 1 > output.count - 1 { t.append(output[h]) }
                else { t.append(merge(output[h], output[h + 1])) }
            }
            output = t
        }
        return output[0]
    }
    
    
// MARK: Program Controller
    
    func sort (array: Array<Int>) -> Array<Int> {
        if array.count < 2 { return array }
        let dissassembled = dissassemble(array)
        let assembled = assemble(dissassembled)
        return assembled
    }
}


let mergeSort = MergeSort()

let ar3 = [2, 3, 7]
let ar5 = [1, 4, 7, 9, 4]
let ar8 = [1, 5, 7, 8, 10, 25, 11, 64]
let ar9 = [1, 5, 7, 8, 10, 25, 11, 64, 5]
let ar10 = [1, 5, 7, 8, 10, 25, 11, 64, 5, 90]
let ar27 = [82, 25, 97, 83, 75, 30, 29, 91, 42, 72, 61, 32, 84, 28, 70, 31, 44, 65, 73, 43,
            12, 33, 85, 53, 60, 13, 93]
let ar49 = [17, 99, 18, 84, 28, 60, 72, 44, 94, 63, 81, 39, 15, 95, 29, 93, 10, 71, 49, 58,
            83, 11, 32, 62, 89, 51, 68, 24, 76, 2, 45, 42, 1, 70, 91, 7, 5, 27, 86, 92, 88,
            77, 79, 21, 55, 38, 30, 26, 54]
let ar95 = [92, 87, 50, 91, 54, 34, 61, 80, 36, 39, 59, 85, 5, 17, 41, 55, 9, 44, 3, 67,
            78, 31, 7, 47, 75, 49, 94, 30, 57, 83, 74, 100, 93, 71, 19, 88, 81, 15, 14, 32,
            77, 97, 6, 23, 20, 33, 65, 29, 22, 16, 82, 73, 21, 11, 62, 98, 96, 25, 13, 90,
            26, 43, 12, 70, 8, 42, 10, 37, 76, 64, 4, 68, 28, 86, 48, 79, 60, 18, 72, 45,
            53, 40, 24, 56, 84, 46, 58, 69, 35, 66, 51, 99, 27, 63, 73]

//print (mergeSort.sort(array: ar95))

