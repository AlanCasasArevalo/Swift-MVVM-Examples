import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            Section(footer: formFooter) {
                TextField("email", text: viewModel.bindings.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Contraseña", text: viewModel.bindings.password)
            }
            .navigationBarItems(trailing: submitButton)
            .navigationTitle("Login")
            .disabled(viewModel.state.isLoggingIn)
            .alert(isPresented: viewModel.bindings.isShowingErrorAlert, content: {
                Alert(
                    title: Text(viewModel.state.errorAlertTitle),
                    message: Text(viewModel.state.errorAlertMessage)
                )
            })
        }
        
    }

    private var submitButton: some View {
        Button(action: viewModel.login){
            Text("Entrar")
        }
        .disabled(viewModel.state.canSubmit == false)
    }

    private var formFooter: some View {
        Text(viewModel.state.footerMessage)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init(initialState: .init()))
    }
}
