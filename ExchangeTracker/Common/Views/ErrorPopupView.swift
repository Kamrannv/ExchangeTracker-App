//
//  ErrorPopupView.swift
//  ExchangeTracker
//
//  Created by Kamran on 04.04.25.
//

import SwiftUI

struct ErrorPopupView: View {
    let message: String

    var body: some View {
        VStack {
            Spacer()

            Text(message)
                .font(.subheadline)
                               .padding()
                               .foregroundColor(.white)
                               .background(Color.red)
                               .cornerRadius(12)
                               .padding(.horizontal)
                               .padding(.bottom, 40)
        }
    }
}
