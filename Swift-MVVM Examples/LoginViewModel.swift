import SwiftUI

struct LoginViewState {
    var email = ""
    var password = ""
    var isLoggingIn = false
    var isShowingErrorAlert = false
    var errorAlertTitle = ""
    var errorAlertMessage = ""
}

extension LoginViewState {
    var canSubmit: Bool {
        email.isEmpty == false && password.isEmpty == false
    }
    
    var footerMessage: String {
        isLoggingIn ? "Haciendo login" : ""
    }
}


final class LoginViewModel: ObservableObject {
    
    @Published private(set) var state: LoginViewState
    
    var bindings: (
        email: Binding<String>,
        password: Binding<String>,
        isShowingErrorAlert: Binding<Bool>
    )  {
        (
            email: Binding(path: \.state.email, object: self),
            password: Binding(path: \.state.password, object: self),
            isShowingErrorAlert: Binding(path: \.state.isShowingErrorAlert, object: self)
        )
    }
    
    init(initialState: LoginViewState) {
        state = initialState
    }
    
    func login() {
        state.isLoggingIn = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.state.isLoggingIn = false
            self?.state.isShowingErrorAlert = true
            self?.state.errorAlertTitle = "titulo de alerta"
            self?.state.errorAlertMessage = "Mensaje de Alerta"
        }
    }
    
}

extension Binding {
    init<ObjetType: AnyObject> (path: ReferenceWritableKeyPath<ObjetType, Value>, object: ObjetType) {
        self.init(get: { object[keyPath: path] }, set: { object[keyPath: path] = $0 })
    }
}
