//
//  SplashView.swift
//  yourph
//
//  Created by Sonal on 30/05/25.
//

import SwiftUI

class NavigationControllerHolder: ObservableObject {
    @Published var navigationController: UINavigationController?

    func setNavigationController(_ navController: UINavigationController?) {
        navigationController = navController
    }
}

class SplashViewController: UIHostingController<SplashView> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct SplashView: View {
    @State private var angle: Angle = .degrees(0)

    var body: some View {
        Color.white
        .ignoresSafeArea()
        .overlay{
            AngularGradient(
                gradient: Gradient(colors: [.black, .black, .black.opacity(0.97), .black.opacity(0.93), .black.opacity(0.9), .black.opacity(0.8)]),
                center: .center,
                angle: angle
            )
            .ignoresSafeArea()
        }
        .task { @MainActor in
            withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
                angle = .degrees(360)
            }
            try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            
            await moveToHomeView()
        }
    }
    
    func moveToHomeView() async {
        await MainActor.run {
            if let window {
                let nav = UINavigationController()
                let navCon = NavigationControllerHolder()
                navCon.setNavigationController(nav)
                let homeView = HomeView().environmentObject(navCon)
                nav.viewControllers = [HomeViewController(rootView: homeView)]
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    window.rootViewController = nav
                })
            }
        }
    }
}
