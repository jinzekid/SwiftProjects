//
//  Document.swift
//  Project5
//
//  Created by apple on 6/13/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

// BEGIN import_mobilecoreservices
import MobileCoreServices
// END import_mobilecoreservices

// Type info and thumbnails

// BEGIN filewrapper_extension
extension NSFileWrapper {
    
    // BEGIN conforms_to_type
    var fileExtension : String? {
        return self.preferredFilename?
            .componentsSeparatedByString(".").last
    }
    
    func conformsToType(type: CFString) -> Bool {
        
        // Get the extension of this file
        guard let fileExtension = fileExtension else {
            // If we can't get a file extension, assume that it doesn't conform
            return false
        }
        
        // Get the file type of the attachment based on its extension
        guard let fileType = UTTypeCreatePreferredIdentifierForTag(
            kUTTagClassFilenameExtension, fileExtension, nil)?
            .takeRetainedValue() else {
                // If we can't figure out the file type from the extension,
                // it also doesn't conform
                return false
        }
        
        // Ask the system if this file type conforms to the provided type
        return UTTypeConformsTo(fileType, type)
    }
    // END conforms_to_type
    
    // BEGIN thumbnail_image
    func thumbnailImage() -> UIImage? {
        
        if self.conformsToType(kUTTypeImage) {
            // If it's an image, return it as a UIImage
            
            // Ensure that we can get the contents of the file
            guard let attachmentContent = self.regularFileContents else {
                return nil
            }
            
            // Attempt to convert the file's contents to text
            return UIImage(data: attachmentContent)
        }
        
        // BEGIN thumbnail_image_location
        if self.conformsToType(kUTTypeJSON) {
            // JSON files used to store locations
            return UIImage(named: "Location")
        }
        
        // END thumbnail_image_location
        
        // BEGIN thumbnail_image_audio
        if (self.conformsToType(kUTTypeAudio)) {
            return UIImage(named: "Audio")
        }
        // END thumbnail_image_audio
        
        // BEGIN thumbnail_image_movie
        if (self.conformsToType(kUTTypeMovie)) {
            return UIImage(named: "Video")
        }
        // END thumbnail_image_movie
        
        // BEGIN thumbnail_image_contact
        if self.conformsToType(kUTTypeContact) {
            return UIImage(named: "Contact")
        }
        // END thumbnail_image_contact
        
        // We don't know what type it is, so return nil
        return nil
    }
    // END thumbnail_image
    
}
// END filewrapper_extension

class Document: UIDocument {
    // BEGIN notification_constants
    static let alertSnoozeAction = "snooze"
    static let alertCategory = "notes-alert"
    // END notification_constants
    
    // BEGIN document_base
    var text = NSAttributedString(string: "") {
        didSet {
            self.updateChangeCount(UIDocumentChangeKind.Done)
        }
    }
    
    var documentFileWrapper = NSFileWrapper(directoryWithFileWrappers: [:])
    
    // BEGIN document_contents_for_type
    override func contentsForType(typeName: String) throws -> AnyObject {
        
        let textRTFData = try self.text.dataFromRange(
            NSRange(0..<self.text.length),
            documentAttributes:
            [NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType])
        
        if let oldTextFileWrapper = self.documentFileWrapper
            .fileWrappers?[NoteDocumentFileNames.TextFile.rawValue] {
            self.documentFileWrapper.removeFileWrapper(oldTextFileWrapper)
        }
        
        // BEGIN document_base_quicklook
        // Create the QuickLook folder
        
        let thumbnailImageData =
            self.iconImageDataWithSize(CGSize(width: 512, height: 512))!
        
        let thumbnailWrapper =
            NSFileWrapper(regularFileWithContents: thumbnailImageData)
        
        let quicklookPreview =
            NSFileWrapper(regularFileWithContents: textRTFData)
        
        let quickLookFolderFileWrapper =
            NSFileWrapper(directoryWithFileWrappers: [
                NoteDocumentFileNames.QuickLookTextFile.rawValue: quicklookPreview,
                NoteDocumentFileNames.QuickLookThumbnail.rawValue: thumbnailWrapper
                ])
        quickLookFolderFileWrapper.preferredFilename =
            NoteDocumentFileNames.QuickLookDirectory.rawValue
        
        // Remove the old QuickLook folder if it existed
        if let oldQuickLookFolder = self.documentFileWrapper
            .fileWrappers?[NoteDocumentFileNames.QuickLookDirectory.rawValue] {
            self.documentFileWrapper.removeFileWrapper(oldQuickLookFolder)
        }
        
        // Add the new QuickLook folder
        self.documentFileWrapper.addFileWrapper(quickLookFolderFileWrapper)
        // END document_base_quicklook
        
        self.documentFileWrapper.addRegularFileWithContents(textRTFData,
                                                            preferredFilename: NoteDocumentFileNames.TextFile.rawValue)
        
        return self.documentFileWrapper
    }
    // END document_contents_for_type
    
    override func loadFromContents(contents: AnyObject,
                                   ofType typeName: String?) throws {
        
        // Ensure that we've been given a file wrapper
        guard let fileWrapper = contents as? NSFileWrapper else {
            throw err(.CannotLoadFileWrappers)
        }
        
        // Ensure that this file wrapper contains the text file,
        // and that we can read it
        guard let textFileWrapper = fileWrapper
            .fileWrappers?[NoteDocumentFileNames.TextFile.rawValue],
            let textFileData = textFileWrapper.regularFileContents else {
                throw err(.CannotLoadText)
        }
        
        // Read in the RTF
        self.text = try NSAttributedString(data: textFileData,
                                           options: [NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType],
                                           documentAttributes: nil)
        
        // Keep a reference to the file wrapper
        self.documentFileWrapper = fileWrapper
        
    }
    // END document_base
    
    // BEGIN document_attachment_dir
    private var attachmentsDirectoryWrapper : NSFileWrapper? {
        
        // Ensure that we can actually work with this document
        guard let fileWrappers = self.documentFileWrapper.fileWrappers else {
            NSLog("Attempting to access document's contents, but none found!")
            return nil
        }
        
        // Try to get the attachments directory
        var attachmentsDirectoryWrapper =
            fileWrappers[NoteDocumentFileNames.AttachmentsDirectory.rawValue]
        
        // If it doesn't exist..
        if attachmentsDirectoryWrapper == nil {
            
            // Create it
            attachmentsDirectoryWrapper =
                NSFileWrapper(directoryWithFileWrappers: [:])
            attachmentsDirectoryWrapper?.preferredFilename =
                NoteDocumentFileNames.AttachmentsDirectory.rawValue
            
            // And then add it
            self.documentFileWrapper.addFileWrapper(attachmentsDirectoryWrapper!)
            
            // We made a change to the file, so record that
            self.updateChangeCount(UIDocumentChangeKind.Done)
        }
        
        // Either way, return it
        return attachmentsDirectoryWrapper
    }
    // END document_attachment_dir
    
    // Attachments
    // BEGIN document_attachments
    dynamic var attachedFiles : [NSFileWrapper]? {
        
        // Get the contents of the attachments directory directory
        guard let attachmentsFileWrappers =
            attachmentsDirectoryWrapper?.fileWrappers else {
                NSLog("Can't access the attachments directory!")
                return nil
        }
        
        // attachmentsFileWrappers is a dictionary mapping filenames
        // to NSFileWrapper objects; we only care about the NSFileWrappers,
        // so return that as an array
        return Array(attachmentsFileWrappers.values)
        
    }
    // END document_attachments
    
    // BEGIN document_add_attachments
    func addAttachmentAtURL(url:NSURL) throws -> NSFileWrapper {
        
        // Ensure that we have a place to put attachments
        guard attachmentsDirectoryWrapper != nil else {
            throw err(.CannotAccessAttachments)
        }
        
        // Create the new attachment with this file, or throw an error
        let newAttachment = try NSFileWrapper(URL: url,
                                              options: NSFileWrapperReadingOptions.Immediate)
        
        // Add it to the attachments directory
        attachmentsDirectoryWrapper?.addFileWrapper(newAttachment)
        
        // Mark ourselves as needing to save
        self.updateChangeCount(UIDocumentChangeKind.Done)
        
        return newAttachment
    }
    // END document_add_attachments
    
    
    // BEGIN document_url_for_attachment
    // Given an attachment, eventually returns its URL, if possible.
    // It might be nil if 1. this isn't one of our attachments or
    // 2. we failed to save, in which case the attachment may not exist
    // on disk
    func URLForAttachment(attachment: NSFileWrapper,
                          completion: NSURL? -> Void) {
        
        // Ensure that this is an attachment we have
        guard let attachments = self.attachedFiles
            where attachments.contains(attachment) else {
                completion(nil)
                return
        }
        
        // Ensure that this attachment has a filename
        guard let fileName = attachment.preferredFilename else {
            completion(nil)
            return
        }
        
        self.autosaveWithCompletionHandler { (success) -> Void in
            if success {
                
                // We're now certain that attachments actually
                // exist on disk, so we can get their URL
                let attachmentURL = self.fileURL
                    .URLByAppendingPathComponent(
                        NoteDocumentFileNames.AttachmentsDirectory.rawValue,
                        isDirectory: true).URLByAppendingPathComponent(fileName)
                
                completion(attachmentURL)
                
            } else {
                NSLog("Failed to autosave!")
                completion(nil)
            }
        }
        
    }
    // END document_url_for_attachment
    
    
    
    // BEGIN document_add_attachment_with_data
    func addAttachmentWithData(data: NSData, name: String) throws {
        
        guard attachmentsDirectoryWrapper != nil else {
            throw err(.CannotAccessAttachments)
        }
        
        let newAttachment = NSFileWrapper(regularFileWithContents: data)
        
        newAttachment.preferredFilename = name
        
        attachmentsDirectoryWrapper?.addFileWrapper(newAttachment)
        
        self.updateChangeCount(.Done)
        
    }
    // END document_add_attachment_with_data
    
    // BEGIN delete_attachment
    func deleteAttachment(attachment:NSFileWrapper) throws {
        
        guard attachmentsDirectoryWrapper != nil else {
            throw err(.CannotAccessAttachments)
        }
        
        
        attachmentsDirectoryWrapper?.removeFileWrapper(attachment)
        
        self.updateChangeCount(.Done)
        
    }
    // END delete_attachment
    
    
    // BEGIN notification_property
    var localNotification: UILocalNotification? {
        
        get {
            if let allNotifications = UIApplication.sharedApplication()
                .scheduledLocalNotifications {
                
                return allNotifications.filter({
                    (item:UILocalNotification) -> Bool in
                    
                    
                    // If it has an "owner", and will appear in the future..
                    if let owner = item.userInfo?["owner"] as? String where
                        item.fireDate?.timeIntervalSinceNow > 0
                    {
                        // Then it is ours if the owner equals our own URL
                        return owner == self.fileURL.absoluteString
                    } else {
                        return false
                    }
                    
                }).first
                
            } else {
                return nil
            }
        }
        
        set {
            if let currentNotification = self.localNotification {
                UIApplication.sharedApplication()
                    .cancelLocalNotification(currentNotification)
            }
            
            if let theNotification = newValue {
                var userInfo = theNotification.userInfo ?? [:]
                userInfo["owner"] = self.fileURL.absoluteString
                theNotification.userInfo = userInfo
                
                UIApplication.sharedApplication()
                    .scheduleLocalNotification(theNotification)
            }
        }
    }
    // END notification_property
    
    // BEGIN ios_thumbnail_icon
    func iconImageDataWithSize(size: CGSize) -> NSData? {
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        
        let entireImageRect = CGRect(origin: CGPoint.zero, size: size)
        
        // Fill the background with white
        let backgroundRect = UIBezierPath(rect: entireImageRect)
        UIColor.whiteColor().setFill()
        backgroundRect.fill()
        
        if self.attachedFiles?.count >= 1 {
            // Render our text, and the first attachment
            let attachmentImage = self.attachedFiles?[0].thumbnailImage()
            
            var firstHalf : CGRect = CGRectZero
            var secondHalf : CGRect = CGRectZero
            
            CGRectDivide(entireImageRect, &firstHalf, &secondHalf,
                         entireImageRect.size.height / 2.0, CGRectEdge.MinYEdge)
            
            self.text.drawInRect(firstHalf)
            attachmentImage?.drawInRect(secondHalf)
        } else {
            // Just render our text
            self.text.drawInRect(entireImageRect)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return UIImagePNGRepresentation(image)
    }
    // END ios_thumbnail_icon
}
