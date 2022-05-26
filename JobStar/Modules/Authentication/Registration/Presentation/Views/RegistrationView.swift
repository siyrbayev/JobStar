//
//  RegistrationView.swift
//  JobStar
//
//  Created by siyrbayev on 17.05.2022.
//

import SwiftUI

// MARK: - Preview

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

struct RegistrationView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: RegistrationViewModel = RegistrationViewModel()
    
    // MARK: - Body
    
    var body: some View {
        SetEmailView(viewModel: viewModel)
    }
}

// MARK: - Private func

private extension RegistrationView {
    func dismissView() {
        dismiss()
    }
}
