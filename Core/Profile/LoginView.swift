import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                // image
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 150)
                    .padding(.vertical, 32)
                
                
                // form fields
                VStack(spacing: 24) {
                    InputView(text: $email, 
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $password, 
                              title: "Password", 
                              placeholder: "Enter your password", 
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                // sign in button
                
                NavigationLink(
                    destination: UserInt(),
                    isActive: $isActive
                ) {
                    EmptyView()
                }
                .hidden()
                
                Button(action:{
                    isActive = true
                    print("Log user in...")
                }) {
                    HStack {
                        Text("Sign in")
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
                // sign up button
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Dont have an account?")
                            .foregroundColor(.black)
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                    }
                    .font(.system(size: 15))
                }
            }
         }
        .navigationBarBackButtonHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        
    }
}
