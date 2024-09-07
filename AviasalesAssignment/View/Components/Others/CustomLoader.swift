import SwiftUI

struct CustomLoader: View {
    @State private var isAnimating: Bool = false
    var timing: Double = 1.32
    
    private let frame = CGSize(width: 42, height: 42)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    AppColor.loaderBackground,
                    style: StrokeStyle(
                        lineWidth: isAnimating ? frame.height / 7 : frame.height / 7,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: frame.width, height: frame.height, alignment: .center)
            
            Circle()
                .trim(from: 0.6, to: 1.0)
                .stroke(
                    AppColor.accentColor,
                    style: StrokeStyle(
                        lineWidth: isAnimating ? frame.height / 7 : frame.height / 7,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .animation(.easeInOut(duration: timing / 2).repeatForever(), value: isAnimating)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(.linear(duration: timing).repeatForever(autoreverses: false), value: isAnimating)
                .frame(width: frame.width, height: frame.height, alignment: .center)
                .rotationEffect(Angle(degrees: 360 * 0.15))
                .onAppear {
                    isAnimating = true
                }
        }
    }
}

#Preview {
    ZStack {
        AppColor.appBackground.ignoresSafeArea()
        
        CustomLoader()
    }
}
