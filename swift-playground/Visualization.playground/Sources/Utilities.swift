import Foundation

import Foundation


public extension Optional {
    
    /**
     This function attempts to extract a meaningful double value from some optional type 
     or returns nil. Although this is not ideal, it's useful for optional chaining to try
     to coerce values from an imported data set.
     */
    public var double: Double? {
        guard let string = self as? String else {
            return nil
        }
        return Double(string)
    }
    
}

