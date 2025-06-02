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
    @State private var showInvalidAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("App-to-Phone Call")
                .font(.title)
            
            TextField("Enter phone number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
                .padding(.horizontal)
            
            Button("Call") {
                if isValidPhoneNumber(phoneNumber) {
                    initiateCall()
                } else {
                    showInvalidAlert = true
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $showInvalidAlert) {
            Alert(
                title: Text("Invalid Phone Number"),
                message: Text("Please enter a valid phone number in international or local format."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func isValidPhoneNumber(_ number: String) -> Bool {
        let pattern = #"^\+?[0-9]{7,15}$"#
        return number.range(of: pattern, options: .regularExpression) != nil
    }
    
    func initiateCall() {
        // Replace this with your manually generated Access Token string
        let hardcodedToken = "<your-jwt-access-token>"

        let connectOptions = ConnectOptions(accessToken: hardcodedToken) { builder in
            builder.params = ["To": phoneNumber]
        }

        viewModel.call = TwilioVoiceSDK.connect(options: connectOptions, delegate: viewModel)
    }
}
