//
//  Models.swift
//  ChillGram
//
//  Created by Youssef Bhl on 09/12/2021.
//

import Foundation

enum Gender {
    case male, female
}

struct user {
    let username: String
    let bio : String
    let name: (first: String, last: String)
    let profilePicture: URL
    let birthDate: Date
    let gender: Gender
    let counts: UserCounts
    let joinDate: Date
}

struct UserCounts {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

public struct UserPost {
    let identifieer: String
    let postType: UserPostType
    let thunmbnailImage: URL
    let postURL: URL //video or photo URL
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUser: [String]
}

struct PostLikes {
    let username: String
    let CommentIdentifier: String
}

struct CommentLike {
    let username: String
    let postIdentifier: String
}

struct PostComment {
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}
