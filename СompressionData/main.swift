let rle = RLE()

func displayMenu() {
    print("""
    ==== RLE File Processor ====
    1. Encode a file
    2. Decode a file
    3. Compare files
    4. Exit
    """)
}


while true {
    displayMenu()
    guard let choice = readLine(), let option = Int(choice) else {
        print("Invalid input. Please enter a number between 1 and 4.")
        continue
    }
    
    switch option {
    case 1: // Encode a file
        print("Enter the path to the file to encode:")
        guard let inputPath = readLine(), let inputData = rle.readFile(at: inputPath) else {
            print("Failed to read the input file.")
            continue
        }
        
        print("Enter the path to save the encoded file:")
        guard let encodedPath = readLine() else {
            print("Invalid file path.")
            continue
        }
        
        let encodedData = rle.encode(data: inputData)
        if rle.writeFile(data: encodedData, to: encodedPath) {
            print("File encoded successfully and saved to \(encodedPath).")
        } else {
            print("Failed to write the encoded file.")
        }
        
    case 2: // Decode a file
        print("Enter the path to the encoded file:")
        guard let encodedPath = readLine(), let encodedData = rle.readFile(at: encodedPath) else {
            print("Failed to read the encoded file.")
            continue
        }
        
        print("Enter the path to save the decoded file:")
        guard let decodedPath = readLine() else {
            print("Invalid file path.")
            continue
        }
        
        let decodedData = rle.decode(data: encodedData)
        if rle.writeFile(data: decodedData, to: decodedPath) {
            print("File decoded successfully and saved to \(decodedPath).")
        } else {
            print("Failed to write the decoded file.")
        }
        
    case 3: // Compare files
        print("Enter the path to the first file:")
        guard let firstPath = readLine(), let firstData = rle.readFile(at: firstPath) else {
            print("Failed to read the first file.")
            continue
        }
        
        print("Enter the path to the second file:")
        guard let secondPath = readLine(), let secondData = rle.readFile(at: secondPath) else {
            print("Failed to read the second file.")
            continue
        }
        
        if rle.equalFiles(firstData, secondData) {
            print("The files are identical.")
        } else {
            print("The files are different.")
        }
        
    case 4: // Exit
        print("Exiting program. Goodbye!")
        break
        
    default:
        print("Invalid option. Please enter a number between 1 and 4.")
    }
}
