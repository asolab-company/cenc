import SwiftUI

enum Tab: Int, CaseIterable {
    case home = 0
    case cart
    case menu

    var url: URL {
        switch self {
        case .home: return URL(string: "https://cenc.com.ua")!
        case .cart: return URL(string: "https://cenc.com.ua/collections/all")!
        case .menu: return URL(string: "https://cenc.com.ua/pages/cenc-home")!
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .cart: return "cart.fill"
        case .menu: return "line.3.horizontal"
        }
    }

    var iconUnselected: String {
        switch self {
        case .home: return "house"
        case .cart: return "cart"
        case .menu: return "line.3.horizontal"
        }
    }
}

private let tabBarIconColor = Color(white: 0.25)

private let tabBarContentHeight: CGFloat = 50
private let homeIndicatorHeight: CGFloat = 34

struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
                .frame(height: homeIndicatorHeight / 2)
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        Image(systemName: selectedTab == tab ? tab.icon : tab.iconUnselected)
                            .font(.system(size: 22, weight: .medium))
                            .foregroundStyle(tabBarIconColor)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(height: tabBarContentHeight)
            Spacer(minLength: 0)
                .frame(height: homeIndicatorHeight / 2)
        }
        .frame(height: tabBarContentHeight + homeIndicatorHeight)
        .frame(maxWidth: .infinity)
        .background(.white)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct MainView: View {
    @State private var selectedTab: Tab = .home

    private let tabBarHeight: CGFloat = tabBarContentHeight + homeIndicatorHeight

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    WebView(url: tab.url, isSelected: selectedTab == tab)
                    .opacity(selectedTab == tab ? 1 : 0)
                    .allowsHitTesting(selectedTab == tab)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, tabBarHeight)

            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    MainView()
}
