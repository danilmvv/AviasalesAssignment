import SwiftUI

struct Badge: View {
    var text: String
    var textColor: Color = AppColor.textButton
    var backgroundColor: Color = AppColor.appGreen
    
    var body: some View {
        Text(text)
            .font(AppFont.badge)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundStyle(textColor)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

#Preview {
    Badge(
        text: "Самый дешёвый"
    )
}
