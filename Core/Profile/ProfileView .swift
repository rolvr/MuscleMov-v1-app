import SwiftUI

struct ProfileView: View {
    @State private var patient = ""
    @State private var id = ""
    var body: some View {
        VStack {
            Image("MuscleMov")
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 150)
                .padding(.vertical, 10)
            
            Image("BlankProfile")
                .resizable()
                .scaledToFit()
                .frame(width: 550, height: 250)
                .padding(.vertical, 5)
            
            VStack(spacing: 5) {
                    Text("Welcome")
                        .fontWeight(.semibold)
                        .padding()
                        
                    Text("name@example.com")
                        .font(.footnote)
                        .accentColor(.gray)
            }
            .padding(.horizontal)
            .padding(.top, 4)
            
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
