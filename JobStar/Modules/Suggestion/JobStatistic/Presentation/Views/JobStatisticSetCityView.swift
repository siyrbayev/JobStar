//
//  JobStatisticSetCityView.swift
//  JobStar
//
//  Created by siyrbayev on 02.05.2022.
//

import SwiftUI


// MARK: - Preview

struct JobStatisticSetCityView_Previews: PreviewProvider {
    static var previews: some View {
        JobStatisticSetCityView(viewModel: JobStatisticViewModel(), isPresented: .constant(false))
    }
}

struct JobStatisticSetCityView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: JobStatisticViewModel
    
    // MARK: - Binding
    
    @Binding var isPresented: Bool
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.tx_sc)
                        .padding(.leading, 8)
                    
                    CustomUITextField(placeHolder: "Search", text: $viewModel.cityNameToSearch, isFirstResponder: true)
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 16, weight: .medium))
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.clear)
                        .background(
                            Color.bg_sc
                                .cornerRadius(12)
                        )
                )
            }
            .frame(height: 40)
            .padding(.horizontal)
            .padding(.bottom)
            
            ScrollView {
                ForEach(viewModel.cities.filter({viewModel.cityNameToSearch.isEmpty ? true : $0.name?.lowercased().contains(viewModel.cityNameToSearch.lowercased()) ?? false})) { city in
                    
                    Button {
                        viewModel.setCity(city)
                        isPresented.toggle()
                    } label: {
                        VStack {
                            HStack {
                                Text(city.name ?? "")
                                Spacer()
                            }
                            .foregroundColor(.tx_pr)
                            
                            Divider()
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
//            viewModel.getCities()
        }
    }
}
