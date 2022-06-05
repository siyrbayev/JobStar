//
//  ResumeDetailsView.swift
//  JobStar
//
//  Created by siyrbayev on 31.05.2022.
//

import SwiftUI

// MARK: - Previews

struct ResumeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResumeDetailsView(viewModel: ProfileViewModel(), resume: Resume.mock()!)
    }
}

struct ResumeDetailsView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: ProfileViewModel
    
    let resume: Resume
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Group {
                    HStack {
                        Text(resume.title ?? "")
                            .foregroundColor(.tx_pr)
                            .font(.system(size: 18, weight: .semibold))
                        
                        Spacer()
                    }
                    .padding()
                    
                    VStack(spacing: 2) {
                        HStack(spacing: 0) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .foregroundColor(.tx_sc)
                                .frame(width: 14, height: 14)
                                .padding(.trailing, 6)
                            
                            Text("\(resume.firstName ?? "") \(resume.secondName ?? "")")
                                .foregroundColor(.tx_sc)
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                        }
                        
                        HStack(spacing: 0) {
                            Image(systemName: "envelope.fill")
                                .resizable()
                                .foregroundColor(.tx_sc)
                                .frame(width: 16, height: 12)
                                .padding(.trailing, 4)
                                .padding(.top, 2)
                            
                            Text(resume.email ?? "")
                                .foregroundColor(.tx_sc)
                                .font(.system(size: 16, weight: .regular))
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    
                    Text(resume.description ?? "")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 14, weight: .regular))
                        .padding()
                    
                    Divider()
                        .foregroundColor(.bg_sc)
                }
                
                Group {
                    HStack {
                        
                        Text("Skills")
                            .foregroundColor(.tx_pr)
                            .font(.system(size: 22, weight: .bold))
                        
                        Spacer()
                        
                        Text("\(resume.skills?.count ?? 0) skills")
                            .foregroundColor(.tx_sc)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding()
                    
                    TagView(skills: resume.skills ?? [])
                        .padding(-4)
                        .padding([.bottom, .horizontal])
                    
                    
                    Divider()
                        .foregroundColor(.bg_sc)
                }
                
                Group {
                    
                    HStack {
                        
                        Text("Work time periods")
                            .foregroundColor(.tx_pr)
                            .font(.system(size: 22, weight: .bold))
                        
                        Spacer()
                        
                        Text("\(String(format: "%.0f", resume.totalWorkTime ?? 0)) years")
                            .foregroundColor(.tx_sc)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding()
                    
                    VStack(spacing: 6) {
                        ForEach(resume.workTimePeriods ?? []) { workTimePeriod in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(workTimePeriod.positionName ?? "")
                                        .font(.system(size: 18, weight: .medium))
                                    
                                    Spacer()
                                    
                                    //                            Button(action: { deleteWorkTimePeriod(at: index) }) {
                                    //                                Image(systemName: "xmark.circle")
                                    //                                    .foregroundColor(.error)
                                    //                                    .font(.system(size: 16))
                                    //                            }
                                }
                                
                                HStack {
                                    Text(workTimePeriod.beginDateTime ?? "")
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 14, weight: .medium))
                                    
                                    Spacer()
                                    
                                    Text(workTimePeriod.endDateTime ?? "")
                                        .font(.system(size: 16, weight: .medium))
                                }
                                .foregroundColor(.tx_off)
                            }
                            .padding(8)
                            .padding(.vertical, 8)
                            .background(Color.bg_off)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
                
//                VStack {
//                    HStack {
//                        
//                        Text("Vacancies")
//                            .foregroundColor(.tx_pr)
//                            .font(.system(size: 22, weight: .bold))
//                        
//                        Spacer()
//                        
//                        Text("\(String(format: "%.0f", resume.totalWorkTime ?? 0)) years")
//                            .foregroundColor(.tx_sc)
//                            .font(.system(size: 14, weight: .semibold))
//                    }
//                    .padding()
//                    
//                    VStack(spacing: 6) {
//                        ForEach(resume.workTimePeriods ?? []) { workTimePeriod in
//                            VStack(alignment: .leading, spacing: 8) {
//                                HStack {
//                                    Text(workTimePeriod.positionName ?? "")
//                                        .font(.system(size: 18, weight: .medium))
//                                    
//                                    Spacer()
//                                }
//                                
//                                HStack {
//                                    Text(workTimePeriod.beginDateTime ?? "")
//                                        .font(.system(size: 16, weight: .medium))
//                                    
//                                    Spacer()
//                                    
//                                    Image(systemName: "arrow.right")
//                                        .font(.system(size: 14, weight: .medium))
//                                    
//                                    Spacer()
//                                    
//                                    Text(workTimePeriod.endDateTime ?? "")
//                                        .font(.system(size: 16, weight: .medium))
//                                }
//                                .foregroundColor(.tx_off)
//                            }
//                            .padding(8)
//                            .padding(.vertical, 8)
//                            .background(Color.bg_off)
//                            .cornerRadius(12)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                .isHidden(<#T##Bool#>, remove: <#T##Bool#>)
            }
            .background(
                Color.bg_clear
            )
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: dismissView) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 16, weight: .medium))
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(role: .destructive, action: delete) {
                        Label {
                            Text("Delete immidiatly")
                                .font(.system(size: 12, weight: .medium))
                        } icon: {
                            Image(systemName: "trash")
                        }
                    }
                } label: {
                    Button(action: dismissView) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.tx_pr)
                            .font(.system(size: 16, weight: .medium))
                    }
                }
            }
        }
    }
}

// MARK: - Private func

private extension ResumeDetailsView {
    
    func dismissView() {
        dismiss()
    }
    
    func delete() {
        guard let id = resume.id else {
            return
        }
        
        viewModel.deleteResume(with: id, {
            dismissView()
        })
    }
}
