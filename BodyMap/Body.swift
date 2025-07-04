import SwiftUI

struct MuscleSelectionView: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        ZStack {
            Image("HumanBody")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            VStack(alignment: .center, spacing: 0) {
                
                HStack(spacing: 0) {
                    // Hombro
                    InvisibleSquareButton(destination: DisplayCont2(), width: 45, height: 45)
                        .position(x: 355, y: 190)
                    Spacer()
                    // Bíceps
                    InvisibleSquareButton(destination: DisplayCont2(), width: 45, height: 55)
                        .position(x: 110, y: 260)
                    Spacer()
                    // Antebrazo
                    InvisibleSquareButton(destination: DisplayCont2(), width: 45, height: 70)
                        .position(x: -145, y: 350) 
                    Spacer()
                    // Muslo
                    InvisibleSquareButton(destination: DisplayCont2(), width: 55, height: 300)
                        .position(x: -330, y: 470)
                    Spacer()
                    // Pierna
                    InvisibleSquareButton(destination: DisplayCont2(), width: 45, height: 90)
                        .position(x: -560, y: 630)
                    Spacer()
                    }                    
                Spacer()
                
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
                        Text("Back")
                            .fontWeight(.semibold)
                            .navigationBarHidden(true)
                    }
                    .foregroundColor(.white)
                    .frame(width:60, height: 48)
                }
                .background(Color(.systemOrange))
                .cornerRadius(10)
                .padding(.top, 500)
            }
        //
        }
    }
}
struct InvisibleSquareButton<Destination: View>: View {
    var destination: Destination
    var width: CGFloat
    var height: CGFloat
    
    @State private var isActive: Bool = false
    
    var body: some View {
        Button(action: {
            isActive = true
        }) {
            Circle()
                .fill(Color.red)
                .frame(width: width, height: height)
                .opacity(0.4)
        }
        .background(
            NavigationLink("", destination: destination, isActive: $isActive)
                .isDetailLink(false)
                .navigationBarBackButtonHidden(true)
                .hidden()
        )
    }
}


struct HumanBodyMap_Previews: PreviewProvider {
    static var previews: some View {
        MuscleSelectionView()
    }
}

