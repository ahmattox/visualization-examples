import Cocoa
import XCPlayground

public extension NSView {
    
    /// Save an eps representation of the view.
    public func saveEPS(fileName fileName:String) {
        let dataDirectory = XCPlaygroundSharedDataDirectoryURL.URLByDeletingLastPathComponent!
        Swift.print("Saved File in Directory:\n" + dataDirectory.path!)
        let filePath = dataDirectory.URLByAppendingPathComponent(fileName + ".eps")
        let imageData = dataWithEPSInsideRect(bounds)
        imageData.writeToFile(filePath.path!, atomically: false)
    }

}

