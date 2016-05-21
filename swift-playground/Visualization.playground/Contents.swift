
import Cocoa
import XCPlayground


let path = NSBundle.mainBundle().pathForResource("Elements", ofType: "csv")!
let data = try String(contentsOfFile: path, encoding: NSASCIIStringEncoding)
let csv = CSwiftV(String: data)
let elements = csv.keyedRows!


class ElementsGraph: NSView {
    override func drawRect(dirtyRect: NSRect) {
        NSColor.blackColor().setFill()
        for element in elements {
            let x = Double(element["Atomic Number"]!)! * 1.6
            let y = Double(element["Atomic Weight"]!)! * 0.6
            let width = 2.0
            let height = 2.0
            let path = NSBezierPath(ovalInRect: NSRect(x: x, y: y, width: width, height: height))
            path.fill()
        }
    }
}

let elementsGraph = ElementsGraph(frame: NSRect(x: 0, y: 0, width: 200, height: 200))


func saveEPS(view:NSView, toFile fileName:String) {
    let dataDirectory = XCPlaygroundSharedDataDirectoryURL.URLByDeletingLastPathComponent!
    print("Saved File in Directory:\n" + dataDirectory.path!)
    let filePath = dataDirectory.URLByAppendingPathComponent(fileName + ".eps")
    let imageData = view.dataWithEPSInsideRect(view.bounds)
    imageData.writeToFile(filePath.path!, atomically: false)
}

saveEPS(elementsGraph, toFile:"elements")


