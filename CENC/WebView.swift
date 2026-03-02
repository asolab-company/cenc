import SwiftUI
import WebKit

struct WebView: View {
    let url: URL
    var isSelected: Bool

    init(url: URL, isSelected: Bool = false) {
        self.url = url
        self.isSelected = isSelected
    }

    var body: some View {
        WebViewRepresentable(url: url, isSelected: isSelected)
            .ignoresSafeArea(.container, edges: .bottom)
    }
}

private let sharedProcessPool = WKProcessPool()

private func isSamePage(_ a: URL?, _ b: URL?) -> Bool {
    guard let a = a, let b = b else { return false }
    return a.host == b.host && (a.path == b.path || (a.path.isEmpty && b.path == "/") || (a.path == "/" && b.path.isEmpty))
}

private struct WebViewRepresentable: UIViewRepresentable {
    let url: URL
    let isSelected: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard isSelected else {
            context.coordinator.lastRequestedURL = nil
            return
        }
        guard !isSamePage(webView.url, url) else { return }
        guard context.coordinator.lastRequestedURL != url else { return }
        context.coordinator.lastRequestedURL = url
        webView.load(URLRequest(url: url))
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.processPool = sharedProcessPool
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.isOpaque = true
        webView.backgroundColor = .white
        webView.scrollView.bounces = true
        webView.allowsBackForwardNavigationGestures = false
        webView.load(URLRequest(url: url))
        return webView
    }

    final class Coordinator {
        var lastRequestedURL: URL?
    }
}

#Preview {
    WebView(url: URL(string: "https://cenc.com.ua")!)
}
