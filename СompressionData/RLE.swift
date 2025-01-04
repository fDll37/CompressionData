import Foundation

final class RLE {

    private lazy var fileManager = FileManager.default
    
    func readFile(at path: String) -> Data? {
        let fileURL = URL(fileURLWithPath: path)
        
        guard fileManager.fileExists(atPath: path) else {
            print("File not found at path \(path)")
            return nil
        }
        
        do {
            return try Data(contentsOf: fileURL)
        } catch {
            print("Error reading file at \(path): \(error.localizedDescription)")
            return nil
        }
    }
    
    func writeFile(data: Data, to path: String) -> Bool {
        var path = path
        var fileURL = URL(fileURLWithPath: path)

        do {
            if fileManager.fileExists(atPath: path) {
                path += "1"
                fileURL = URL(fileURLWithPath: path)
//                try fileManager.removeItem(at: fileURL) // Удаляем старый файл, если он существует
            }
            try data.write(to: fileURL)
            return true
        } catch {
            print("Error writing file at \(path): \(error.localizedDescription)")
            return false
        }
    }
    
    func encode(data: Data) -> Data {
        var encodedData = Data()
        var currentByte: UInt8?
        var count: UInt8 = 0
        
        for byte in data {
            if byte == currentByte && count < UInt8.max {
                count += 1
            } else {
                if let current = currentByte {
                    encodedData.append(current)
                    encodedData.append(count)
                }
                
                currentByte = byte
                count = 1
            }
        }
        
        if let current = currentByte {
            encodedData.append(current)
            encodedData.append(count)
        }
        
        return encodedData
    }
    
    func decode(data: Data) -> Data {
        var decoderData = Data()
        var i = 0
        
        while i < data.count {
            let byte = data[i]
            let count = data[i + 1]
            decoderData.append(contentsOf: Array(repeating: byte, count: Int(count)))
            i += 2
        }
        
        return decoderData
    }
    
    func equalFiles(_ fileOne: Data, _ fileTwo: Data) -> Bool {
        fileOne == fileTwo
    }
    
}

