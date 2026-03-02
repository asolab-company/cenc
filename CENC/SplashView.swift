import SwiftUI

struct SplashView: View {
    var onFinish: () -> Void

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            AnimatedLogoView()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                onFinish()
            }
        }
    }
}

#Preview {
    SplashView(onFinish: {})
}
