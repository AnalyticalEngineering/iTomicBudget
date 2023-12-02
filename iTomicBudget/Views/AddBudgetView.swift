//
//  AddBudgetView.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 12/1/23.
//

import SwiftUI

import SwiftUI

struct AddBudgetView: View {
    @EnvironmentObject var appVM: iTomicViewModel
    @EnvironmentObject var budgetVM: BudgetViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var nameIsFocused: Bool
    
    @State var selectedType: BudgetType = .expense
    @State private var name: String = ""
    @State private var selectedImage: String = "folder.circle"
    @State private var selectedColor: String = "colorBlue"
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Spacer()
                            Image(systemName: selectedImage)
                                .foregroundColor(Color(.black))
                                .font(.system(size: 50))
                                .frame(width: 100, height: 100)
                                .background(Color(selectedColor))
                                .cornerRadius(25)
                            Spacer()
                        } .padding(.bottom, 15)
                        
                        Section {
                            VStack(alignment: .leading) {
                                Picker("Type", selection: $selectedType) {
                                    ForEach(BudgetType.allCases, id: \.self) { type in
                                        Text(type.localizedName())
                                    }
                                }
                                .pickerStyle(.segmented)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("colorBalanceBG"))
                                .cornerRadius(10)
                                .padding(.bottom, 15)
                            }
                        } header: {
                            Text("Select type:")
                                .font(.caption).textCase(.uppercase)
                                .padding(.leading, 10)
                        }
                        
                        Section {
                            VStack(alignment: .leading) {
                                TextField("Name", text: $name)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color("colorBalanceBG"))
                                    .cornerRadius(10)
                                    .padding(.bottom, 15)
                                    .focused($nameIsFocused)
                            }
                        } header: {
                            Text("Enter Name")
                                .font(.caption).textCase(.uppercase)
                                .padding(.leading, 10)
                        }
                        .onTapGesture {
                            nameIsFocused.toggle()
                        }
                        
                        Section {
                            IconPickerView(selectedImage: $selectedImage)
                        } header: {
                            Text("Choose an icon:")
                                .font(.caption).textCase(.uppercase)
                                .padding(.leading, 10)
                        }
                        Section {
                            Text("Color Picker")
                                .padding(5)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("colorBalanceBG"))
                                .cornerRadius(10)
                            
                        } header: {
                            Text("Choose color:")
                                .font(.caption).textCase(.uppercase)
                                .padding(.leading, 10)
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 20)
                }
            }
            .background(Color("colorBG"))
            .navigationBarTitle("Budget Creation Center", displayMode: .inline)
            .scrollDismissesKeyboard(.immediately)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if name.isEmpty {
                            showAlert.toggle()
                        } else {
                            HapticManager.notification(type: .success)
                            budgetVM.saveBudget(name: name, icon: selectedImage, color: selectedColor, type: selectedType)
                            dismiss()
                        }
                    } label: {
                        if name.isEmpty {
                            Text("Add")
                                .foregroundColor(.gray)
                        } else {
                            Text("Add")
                        }
                    }
                }
            }
            .alert("tesrt", isPresented: $showAlert) {
                    Button("Okay", role: .cancel) {
                }
            }
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView()
            .environmentObject(iTomicViewModel())
    }
}
