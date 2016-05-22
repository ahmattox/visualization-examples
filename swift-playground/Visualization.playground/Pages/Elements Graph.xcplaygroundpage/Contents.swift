import Cocoa


/**
 This demonstrates how a csv can be loaded and used to draw a simple scatter plot. The
 scatter plot is then exported as an eps which can be imported into a vector graphics
 program.
 */


/**
 A object which represents an Element. We create a collection of these objects from the 
 loaded data. Although the data could be used directly, converting it into objects makes
 accessing attributes of the elements easier.
 */
class Element {
    
    var atomicNumber: Double?
    var atomicWeight: Double?
    
    init(attributes: [String: String]) {
        atomicNumber = attributes["Atomic Number"].double
        atomicWeight = attributes["Atomic Weight"].double
    }
    
}




// Load the contents of a csv. This function is defined in the sources folder. The data is
// loaded as a collection of strings.
let elementAttributes = loadCSV("Elements")!

// Maps the loaded data into our element objects
let elements = elementAttributes.map { Element(attributes: $0) }


// A custom view class which draws a scatter plot of attributes of elements. In this view
// we override the draw function to create our graph.
class ElementsGraph: NSView {
    
    override func drawRect(dirtyRect: NSRect) {
        
        NSColor.whiteColor().setFill()
        NSBezierPath(rect: bounds).fill()
        
        let scaleX = bounds.width / CGFloat(elements.flatMap({$0.atomicNumber!}).maxElement()!)
        let scaleY = bounds.height / CGFloat(elements.flatMap({$0.atomicWeight!}).maxElement()!)
        
        NSColor.blueColor().setFill()
        for element in elements {
            let x = CGFloat(element.atomicNumber!) * scaleX
            let y = CGFloat(element.atomicWeight!) * scaleY
            let path = NSBezierPath(ovalInRect: NSRect(x: x, y: y, width: 2.0, height: 2.0))
            path.fill()
        }
    }
    
}


// Create an instance of our graph view
let elementsGraph = ElementsGraph(frame: NSRect(x: 0, y: 0, width: 200, height: 200))



// Save an eps file of our view with a given name. The exact path to the file will be 
// logged to the console.
elementsGraph.saveEPS(fileName:"elements")


