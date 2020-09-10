//
//  EditJobView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/10/20.
//

import SwiftUI

struct EditJobView: View {
    // MARK: - Properties

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var jobStore: JobStore

    @State private var titleText = ""
    @State private var companyText = ""
    @State private var dateApplied = Date()
    @State private var contactText = ""
    @State private var status = 0

    @State private var statusPickerVisible = false
    @State private var errorAlertVisible = false

    private var statusOptions: [Status] = [.applied, .offer, .onSite, .phoneScreen, .rejected]

    // MARK: - Methods

    private func cancelButtonTapped() {
        presentationMode.wrappedValue.dismiss()
    }

    private func doneButtonTapped() {
        if titleText.isEmpty || companyText.isEmpty {
            errorAlertVisible = true
        } else {

        }
    }

    private func toggleStatusPicker() {
        withAnimation {
            statusPickerVisible.toggle()
        }
    }

    private var errorAlert: Alert {
        Alert(
            title: Text("Error"),
            message: Text("A job title and company name is needed to add a new job. Please enter them and try again."),
            dismissButton: .default(Text("Okay"))
        )
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $titleText)
                    TextField("Company", text: $companyText)
                    TextField("Phone number or email", text: $contactText)
                }
                Section {
                    DatePicker("Date", selection: $dateApplied, displayedComponents: .date)
                    Button(action: toggleStatusPicker) {
                        HStack {
                            Text("Status")
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(statusOptions[status].rawValue)")
                                .foregroundColor(.secondary)
                        }
                    }
                    if statusPickerVisible {
                        Picker("Status", selection: $status) {
                            ForEach(0..<statusOptions.count) { index in
                                Text(statusOptions[index].rawValue)
                                    .tag(index)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
            }
            .alert(isPresented: $errorAlertVisible) { errorAlert }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Edit job")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: cancelButtonTapped)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: doneButtonTapped)
                }
            }
        }
    }
}

#if DEBUG
struct EditJobViewPreviews: PreviewProvider {
    static var previews: some View {
        EditJobView()
    }
}
#endif
