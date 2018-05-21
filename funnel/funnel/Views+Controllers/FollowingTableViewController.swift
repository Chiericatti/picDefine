//
//  PersonalFeedViewController.swift
//  funnel
//
//  Created by Alec Osborne on 5/14/18.
//  Copyright © 2018 Rodrigo Sagebin. All rights reserved.
//

import UIKit

class FollowingTableViewController: UITableViewController {

    // MARK: - Properties
    var sectionTitles: [String] = []
    var userPosts = [Post]()
    var userSuggestions = [Post]()
    var userFollowings = [Post]()
//    let userContent = [[self.userPosts], [self.userSuggestions], [self.userFollowings]]
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Following"
    }
    
    
    // MARK: - TableView Methods
    // Sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var sectionCount = 0
        
        let userPosts = PostController.shared.userPosts.count // Change to 1 from 0 if user has any posts
        if userPosts > 0 {
            sectionCount += 1
            sectionTitles.append("My Posts")
        }
        
        let submittedAnswers = 1 // Change to 1 from 0 if user has any suggested answers
        if submittedAnswers > 0 {
            sectionCount += 1
            sectionTitles.append("My Suggested Answers")
        }
        
        let followingPosts = 1 // Change to 1 from 0 if user is following posts
        if followingPosts > 0 {
            sectionCount += 1
            sectionTitles.append("Posts I'm Following")
        }
        
        let commentedOn = 0 // Change to 1 if user has any comments // Maybe impliment later on
        if commentedOn > 0 {
            sectionCount += 1
            sectionTitles.append("Posts I have commented on")
        }
        
        return sectionCount
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard sectionTitles.indices ~= section else { return nil }
        return sectionTitles[section]
    }
    
    // Rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight = 115
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136: cellHeight = 115; print("5, 5S, 5C, SE")
            case 1334: cellHeight = 122; print("6, 6S, 7, 8")
            case 2208: cellHeight = 125; print("6+, 6S+, 7+, 8+")
            case 2436: cellHeight = 122; print("X")
            default: print("Unknown Device Height \(#function)")
            }
        }
        return CGFloat(cellHeight)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 { // User posts
            let userPosts = PostController.shared.userPosts.count
            return userPosts
        }
        
        if section == 1 { // User submissions
            
        }
        
        if section == 2 { // User followings
            
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? FollowingTableViewCell else { return UITableViewCell() }
        
        let posts = PostController.shared.userPosts[indexPath.row]
        if indexPath.section == 0 {
            cell.userPost = posts
        }
        
//        let suggestions = PostController.shared
//        if indexPath.section == 1 {
//            cell.userSuggestion =
//        }
        
        
//        let following = PostController.shared
        
        
        return cell
    }
}
