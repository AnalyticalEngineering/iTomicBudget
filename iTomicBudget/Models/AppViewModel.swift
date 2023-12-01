//
//  ItomicViewModel.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import Foundation
import RealmSwift
import SwiftUI

final class iTomicViewModel: ObservableObject {
    
   
    @AppStorage("hasRunBefore") var hasRunBefore: Bool = false
    @AppStorage("currencySymbol") var currencySymbol: String = "USD"
    @AppStorage("roundingNumbers") var roundingNumbers: Bool = false
    
    init() {
        let config = Realm.Configuration(schemaVersion: 01)
        Realm.Configuration.defaultConfiguration = config
    }
}

