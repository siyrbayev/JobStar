//
//  CityListView.swift
//  JobStar
//
//  Created by siyrbayev on 24.05.2022.
//

import SwiftUI

struct CityListView: View {
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: HomeViewModel
    
    // MARK: - Binding
    
    @Binding var isPresented: Bool
    
    // MARK: - State
    
    @State private var cityNameToSearch: String = ""
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            CustomUISearchBar(text: $cityNameToSearch)

            List {
                ForEach(viewModel.cities.filter({cityNameToSearch.isEmpty ? true : $0.name?.lowercased().contains(cityNameToSearch.lowercased()) ?? false})) { city in

                    Button {
                        viewModel.setCity(city)
                        isPresented.toggle()
                    } label: {
                        HStack {
                            Text(city.name ?? "")
                            Spacer()
                        }
                        .foregroundColor(.tx_pr)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getCities()
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView(viewModel: HomeViewModel(), isPresented: .constant(true))
    }
}
