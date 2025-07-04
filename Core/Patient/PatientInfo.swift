import SwiftUI

struct PatientInfo: View {
    @State private var isActive: Bool = false
    @State private var patient = ""
    @State private var id = ""
    
    
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                
                Image("LogoAmarillo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                InputView(text: $patient,
                          title:"Patient name",
                          placeholder: "Enter patient's name",
                          isSecureField:false)
                
                InputView(text: $id, 
                          title:"Patient's ID",
                          placeholder: "Enter patient's ID",
                          isSecureField: false)
            }
            .padding(.horizontal)
            .padding(.top, 12)
        
            NavigationLink (
                destination: TableView(),
                isActive: $isActive
            ) {
                EmptyView()
            }
            .navigationBarHidden(true)
            
            Button {
                print("Searching patient...")
                isActive = true
            } label: {
                HStack {
                    Text("Search")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemYellow))
            .cornerRadius(25)
            .padding(.top, 20)
            
            
            NavigationLink {
                RegistrationPanel()
                    .navigationBarBackButtonHidden(true)
            } label: {
                HStack(spacing: 3){
                    Text("Missing patient?")
                        .foregroundColor(.black)
                    Text("Register")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .font(.system(size: 15))
            }
        }   
}
    struct PatientRegister_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfo()
    }
  }
}
