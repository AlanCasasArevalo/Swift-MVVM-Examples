import SwiftUI

@main
struct Swift_MVVM_ExamplesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView(viewModel: LoginViewModel(initialState: .init()))
            }
        }
    }
}
