import SwiftUI

struct PatientData: Identifiable {
    var id = UUID()
    var name: String
    var age: Int
    var diagnosis: String
    var tests: [String]
}

class DataBaseManager: ObservableObject {
    @Published var patients: [PatientData]
    
    init() {
        self.patients = [
            PatientData(name: "Rolando Rodríguez", age: 22, diagnosis: "Anterior cruciate Ligament", tests: ["Asymmetry test"]),
            PatientData(name: "Benjamín Yepez", age: 21, diagnosis: "Quadriceps contracture", tests: ["Muscle strength evaluation"])
        ]
    }
    func searchPatients(query: String) -> [PatientData] {
        return patients.filter { $0.name.lowercased().contains(query.lowercased())}
    }
}

struct DataBase: View {
    @State private var searchText = ""
    @StateObject private var databaseManager = DataBaseManager()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                List(databaseManager.searchPatients(query: searchText)) { patient in
                    NavigationLink(destination: PatientDetail(patient: patient)) {
                        Text(patient.name)
                    }
                }
            }
            .navigationTitle("Patient data")
        }
    }
}


struct SearchBar: View {
    @Binding var text: String 
    
    var body: some View {
        HStack {
            TextField("Search patient", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 10)
        }
        .padding(.top, 10)
    }
}

struct PatientDetail: View {
    var patient: PatientData
    
    var body: some View {
        VStack {
            Image("BlankProfile")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 200)
            Text("Name: \(patient.name)")
            Text("Age: \(patient.age)")
            Text("Diagnosis: \(patient.diagnosis)")
            
            Section(header: Text("Tests and analysis:")) {
                ForEach(patient.tests, id: \.self) { test in 
                    Text(test)
                }
            }
        }
        .navigationTitle(patient.name)
    }
}


struct DataBase_Previews: PreviewProvider {
    static var previews: some View {
        DataBase()
    }
}
