//
//  LoadingView.swift
//  Acronyms
//
//  Created by Brijesh on 10/12/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: ColorConstant.AccentColor))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//MARK: - Preview
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
