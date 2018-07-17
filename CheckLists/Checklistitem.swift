//
//  Checklistitem.swift
//  CheckLists
//
//  Created by Nour Abukhaled on 2/25/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggelChecked() {
        checked = !checked
    }
}
