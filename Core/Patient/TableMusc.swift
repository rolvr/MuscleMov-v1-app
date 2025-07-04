import SwiftUI

struct TableView: View {
    @State private var isActive: Bool = false
    var body: some View {
        VStack {
            Text("Select the sport to analyse")
                .font(.system(size: 24, weight: .bold, design: .default))

            HStack {
                NavigationLink(destination: MuscleSelectionView()) {
                    ButtonSquare(systemName: "bicycle", color: .yellow)
                }
                
                NavigationLink(destination: MuscleSelectionView()) {
                    ButtonSquare(systemName: "figure.walk.motion", color: .yellow)
                }
            }
            
            HStack {
                NavigationLink(destination: MuscleSelectionView()) {
                    ButtonSquare(systemName: "soccerball", color: .yellow)
                }
                
                NavigationLink(destination: MuscleSelectionView()) {
                    ButtonSquare(systemName: "volleyball", color: .yellow)
                }
            }
            
            NavigationLink (
                destination: UserInt(),
                isActive: $isActive
            ) {
                EmptyView()
            }
            .navigationBarHidden(true)
            
            Button(action:{
                isActive = true
            }) {
                HStack {
                    Text("Back")
                        .fontWeight(.semibold)
                        .navigationBarHidden(true)
                }
                .foregroundColor(.white)
                .frame(width:60, height: 48)
            }
            .background(Color(.systemOrange))
            .cornerRadius(10)
            .padding(.top)

            
        }
        .padding()
        }
        
}

struct ButtonSquare: View {
    var systemName: String
    var color: Color
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 50)
                .foregroundColor(.white)
                .padding()
        }
    }
}


struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView()
    }
}
