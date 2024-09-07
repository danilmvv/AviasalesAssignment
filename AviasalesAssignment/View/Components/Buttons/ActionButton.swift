import SwiftUI

struct ActionButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(AppFont.button)
                .foregroundStyle(AppColor.textButton)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppColor.accentColor)
                }
        }
    }
}

#Preview {
    ZStack {
        AppColor.appBackground.ignoresSafeArea()
        
        ActionButton(title: "Повторить") { }
            .padding()
    }
}
