//
//  WebView.swift
//  LiftofX
//
//  Created by SyberPoiint on 5/17/2022.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {

    typealias UIViewType = WKWebView
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString){
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
