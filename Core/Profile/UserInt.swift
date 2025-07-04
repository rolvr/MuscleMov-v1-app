import SwiftUI


struct UserInt: View {
    @State private var showingLogoutAlert = false
    @State private var redirectToLogin = false
    
    var body: some View {
    TabView {
        ProfileView()
            .tabItem {
                Label("Profile", systemImage: "person")
                .navigationBarBackButtonHidden(true)
            }
        
        PatientInfo()
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
                .navigationBarBackButtonHidden(true)
            }
        
        DataBase()
            .tabItem {
                Label("Data base", systemImage: "folder.fill")
                .navigationBarBackButtonHidden(true)
            }
        
        AccountSettingsView()
            .tabItem {
                Label("Settings", systemImage: "gear")
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}
 

struct UserInt_Previews: PreviewProvider {
    static var previews: some View {
        UserInt()
    }
}
