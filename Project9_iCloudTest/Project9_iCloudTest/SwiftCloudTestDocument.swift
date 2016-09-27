//
//  SwiftCloudTestDocument.swift
//  Project9_iCloudTest
//
//  Created by apple on 6/15/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

enum DocumentReadError: ErrorType {
    case InvalidInput
}

enum DocumentWirteError: ErrorType {
    case NoContentToSave
}

class SwiftCloudTestDocument: UIDocument {
    var documentContents: String?
    
    override init(fileURL url: NSURL) {
        super.init(fileURL: url)
    }
    
    override func loadFromContents(contents: AnyObject, ofType typeName: String?) throws {
        if let castedContents = contents as? NSData {
            documentContents = NSString(data: castedContents, encoding: NSUTF8StringEncoding) as? String
            NSNotificationCenter.defaultCenter().postNotificationName("refreshDocumentPreview", object: self)
        } else {
            documentContents = nil
            throw DocumentReadError.InvalidInput
        }
    }
    
    override func contentsForType(typeName: String) throws -> AnyObject {
        if documentContents == nil {
            throw DocumentWirteError.NoContentToSave
        }
        return (documentContents?.dataUsingEncoding(NSUTF8StringEncoding)!)!
    }
}
