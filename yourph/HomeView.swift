//
//  HomeView.swift
//  yourph
//
//  Created by Sonal on 02/06/25.
//

import UIKit
import SwiftUI
import TwilioVoice

class HomeViewController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var phoneNumber: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("App-to-Phone Call")
                .font(.title)
            
            TextField("Enter phone number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
                .padding(.horizontal)
            
            Button("Call") {
                initiateCall()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
    
    func initiateCall() {
        Task {
            guard let token = await fetchAccessToken() else {
                print("Failed to get token")
                return
            }

            let connectOptions = ConnectOptions(accessToken: token) { builder in
                builder.params = ["To": phoneNumber]
            }

            viewModel.call = TwilioVoiceSDK.connect(options: connectOptions, delegate: viewModel)
        }
    }

    func fetchAccessToken() async -> String? {
        guard let url = URL(string: "https://<your-firebase-url>/getTwilioToken") else {
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json?["token"] as? String
        } catch {
            print("Token fetch error: \(error)")
            return nil
        }
    }
}
