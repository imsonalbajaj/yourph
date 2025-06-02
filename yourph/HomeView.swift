//
//  HomeView.swift
//  yourph
//
//  Created by Sonal on 02/06/25.
//

import UIKit
import SwiftUI

class HomeViewController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct HomeView: View {
    var body: some View {
        Text("You are at home")
    }
}
