//
//  HomeViewModel.swift
//  yourph
//
//  Created by Sonal on 02/06/25.
//

import SwiftUI
import TwilioVoice

class HomeViewModel: NSObject, ObservableObject, CallDelegate {
    @Published var call: Call?
    
    
    func callDidConnect(call: Call) {
        print("Call connected")
    }
    
    func callDidFailToConnect(call: Call, error: Error) {
        print("Call failed to connect: \(error.localizedDescription)")
    }
    
    func callDidDisconnect(call: Call, error: Error?) {
        print("Call disconnected")
        if let error = error {
            print("Error: \(error.localizedDescription)")
        }
    }
}
