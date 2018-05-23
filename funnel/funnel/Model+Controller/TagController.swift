//
//  TagController.swift
//  funnel
//
//  Created by Drew Carver on 5/17/18.
//  Copyright © 2018 Rodrigo Sagebin. All rights reserved.
//

import Foundation
import CloudKit

class TagController {
    
    let ckManager = CloudKitManager()
    
    static let shared = TagController()
    
    func createTagsOnPostFromString(post: Post, tagString: String) {
        var tags: [Tag] = []
        
        let textSeparatedBySpaces = tagString.components(separatedBy: " ")
        let tagsAsStrings = textSeparatedBySpaces.filter { (word) -> Bool in
            return word.hasPrefix("#")
        }
        
        let postReference = CKReference(recordID: post.ckRecordID ?? post.ckRecord.recordID, action: .deleteSelf)
        
        for string in tagsAsStrings {
            let tag = Tag(text: string, postReference: postReference)
            tags.append(tag)
            
            ckManager.save(records: [tag.ckRecord], perRecordCompletion: nil) { (records, error) in
                if let error = error {
                    print("Error saving tag to CloudKit: \(error)")
                    return
                }
            }
        }
    }
    
    
    func fetchTagsFor(post: Post, completion: @escaping ([Tag]?) -> Void) {
        
        let predicate = NSPredicate(format: "postReference == %@", post.ckRecordID ?? post.ckRecord.recordID)
        
        ckManager.fetch(type: Tag.typeKey, predicate: predicate, sortDescriptor: nil) { (records, error) in
            if let error = error {
                print("Error loading tags for post: \(error)")
                completion(nil)
                return
            }
            
            guard let tagsArray = records?.compactMap({Tag(cloudKitRecord: $0)}) else { return }
            completion(tagsArray)
        }
        
    }
    
    
}
