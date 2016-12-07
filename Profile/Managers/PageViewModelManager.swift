//
//  PageViewModelManager.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation

//Model for PageView on AuthViewController

struct PageViewModel {
    let title : String
    let imageURL : String
}

class PageViewModelManager {
    static func all() -> [PageViewModel] {
        return [
            PageViewModel(title: "First", imageURL: "FirstImg"),
            PageViewModel(title: "Second", imageURL: "SecondImg"),
            PageViewModel(title: "Hello", imageURL: "HelloImg")
        ]
    }
}
