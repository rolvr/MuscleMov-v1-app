import SwiftUI

struct Quads: View {
    var body: some View {
        VStack {
            Image("Quads")
                .resizable()
                .scaledToFit()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct QuadsView_Previews: PreviewProvider {
    static var previews: some View {
        Quads()
    }
}
