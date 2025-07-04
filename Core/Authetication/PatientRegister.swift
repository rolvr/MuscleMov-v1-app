import SwiftUI
import SwiftUI

struct RegistrationPanel: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var sex: String = ""
    @State private var birthDate: String = ""
    @State private var age: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bmi: String = ""
    @State private var discipline: String = ""
    
    @State private var isActive: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Column 1
            RegistrationField(title: "Name(s)", value: $firstName)
            RegistrationField(title: "Surname(s)", value: $lastName)
            RegistrationField(title: "Birth date", value: $birthDate)
            RegistrationField(title:  "Age", value: $age)
            RegistrationField(title: "Sex", value: $sex)
            
            // Column 2
            RegistrationField(title:"Height (cm)", value: $height)
            RegistrationField(title:"Weight (kg)", value: $weight)
            RegistrationField(title: "BMI(kg/lb)", value: $bmi)
            RegistrationField(title: "Discipline", value: $discipline)
            
            HStack(spacing: 250) {
        
                NavigationLink (
                    destination: TableView(),
                    isActive: $isActive
                ) {
                    EmptyView()
                }
                .navigationBarHidden(true)
                
                Button(action:{
                    isActive = true
                }) {
                    HStack {
                        Text("Register")
                            .fontWeight(.semibold)
                            .navigationBarHidden(true)
                    }
                    .foregroundColor(.white)
                    .frame(width:80, height: 48)
                }
                
                .background(Color(.systemYellow))
                .cornerRadius(10)
                .padding()
                
                
                NavigationLink{
                    UserInt()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Already patient registered?")
                            .foregroundColor(.black)
                        Text("Go back")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                    }
                    .font(.system(size: 15))
                
            }
            
        }
        .padding()
    }
    }
}

struct RegistrationField: View {
    var title: String
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField("---", text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 150)
        }
    }
}

struct PatientRegister_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationPanel()
    }
}
