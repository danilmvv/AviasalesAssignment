import SwiftUI

struct BuyButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(AppFont.button)
                .foregroundStyle(AppColor.textButton)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppColor.appOrange)
                }
                .shadow(color: AppColor.buttonShadow, radius: 16, x: 0, y: 8)
            
        }
    }
}

#Preview {
    ZStack {
        AppColor.appBackground.ignoresSafeArea()
        
        BuyButton(title: "Купить билет за 17 830 ₽") {
            //
        }
        .padding(8)
    }
}
