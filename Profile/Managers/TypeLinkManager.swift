//
//  TypeLinkManager.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 12.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation

class TypeLinkManager {
    static func all() -> [RealmTypeLink] {
        return [
            RealmTypeLink(name: "VK", basicURL: "https://vk.com/", imageURL: "vkLogo"),
            RealmTypeLink(name: "Facebook", basicURL: "https://fb.com/", imageURL: "fbLogo"),
            RealmTypeLink(name: "Instagram", basicURL: "https://instagram.com/", imageURL: "instagramLogo"),
            RealmTypeLink(name: "Soundcloud", basicURL: "https://soundcloud.com/", imageURL: "soundcloudLogo"),
            RealmTypeLink(name: "Twitter", basicURL: "https://twitter.com/", imageURL: "twitterLogo"),
            RealmTypeLink(name: "LinkedIn", basicURL: "https://linkedin.com/", imageURL: "linkedinLogo"),
            RealmTypeLink(name: "Behance", basicURL: "https://behance.com/", imageURL: "behanceLogo"),
        ]
    }
}
