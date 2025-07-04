import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 150)
                .padding(.vertical, 10)
            
            VStack(spacing: 24) {
                InputView(text: $email, 
                          title: "Email Address",
                          placeholder: "name@example.com")
                .autocapitalization(.none)
                
                InputView(text: $fullname,
                          title: "Full Name",
                          placeholder: "Enter your name")
                
                InputView(text: $password, 
                          title: "Password", 
                          placeholder: "Enter your password", 
                          isSecureField: true)
                
                InputView(text: $confirmPassword,
                          title: "Confirm password",
                          placeholder: "Confirm your password",
                          isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Button{
                print("Sign user up...")
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width:UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemYellow))
            .cornerRadius(25)
            .padding(.top, 20)
            
            Spacer()
            
            Button{
                dismiss()
            } label: {
                HStack(spacing:3){
                    Text("Already have an account?")
                        .foregroundStyle(Color(.black))
                    Text("Sign in")
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.black))
                }
                .font(.system(size:15))
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
