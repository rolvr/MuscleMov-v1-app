import SwiftUI

struct AccountSettingsView: View {
    @State private var showAlert = false
    @State private var navigateToLogin = false 
    
    var body: some View {
        List {
            HStack(spacing: -400) {
                Spacer()
                Image("LogoAmarillo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 150)
                    .padding()
                
                Spacer()
                
                Image("MuscleMov")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 150)
                    .padding()
                Spacer()
            }
            Text("Account settings")
            Text("App settings")
            Text("Help and feedback")
            Button(action: {
                showAlert = true
            }) {
                Text("Log out")
                    .foregroundColor(.red)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Would you like to log out"), 
                primaryButton: .default(Text("Yes")) {
                    navigateToLogin = true
                },
                secondaryButton: .cancel(Text("No")) {
                    showAlert = false
                }
            )
        }
        .background (
            NavigationLink("", destination: LoginView(), isActive: $navigateToLogin)
                .navigationBarBackButtonHidden(true)
        )
        .navigationBarBackButtonHidden(true)
    }   
}


struct AccountSettingView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
    }
}

