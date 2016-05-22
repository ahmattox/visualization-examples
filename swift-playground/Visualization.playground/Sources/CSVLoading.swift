import Foundation


/**
 Loads the contents of a csv file with a given name from the playground. The file should
 be within the resources folder of the playground. This could fail if the file does not
 exist, or can not be read.
 
 The csv is returned as an array of dictionaries. Each dictionary represents one row. Keys
 in each dictionary are pulled from the first row of the file.
 */
public func loadCSV(name: String) -> [[String : String]]? {
    guard let path = NSBundle.mainBundle().pathForResource(name, ofType: "csv") else {
        print("Unable to load csv named '\(name)': No csv file of that name found.")
        return nil
    }
    guard let data = try? String(contentsOfFile: path, encoding: NSASCIIStringEncoding) else {
        print("Unable to load csv named '\(name)': Unable to load contents of file.")
        return nil
    }
    let csv = CSwiftV(String: data)
    return csv.keyedRows
}

