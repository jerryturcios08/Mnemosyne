//
//  JobSheetView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI

struct JobSheetView: View {
    // MARK: - Properties

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var jobStore: JobStore

    // TODO: Add these fields to core data model
    @State private var jobTitle = ""
    @State private var jobCompany = ""
    @State private var dateApplied = Date()
    @State private var favorited = false
    @State private var status = 0

    // Alert visibility boolean values
    @State private var statusPickerVisible = false
    @State private var errorAlertVisible = false

    private var statusOptions: [Status] = [.applied, .offer, .onSite, .phoneScreen, .rejected]

    // MARK: - Methods

    private func cancelButtonTapped() {
        presentationMode.wrappedValue.dismiss()
    }

    private func doneButtonTapped() {
        if jobTitle.isEmpty || jobCompany.isEmpty {
            errorAlertVisible = true
        } else {
            // TODO: Implement call to database to add job
            let job = Job(title: jobTitle, company: jobCompany, dateApplied: dateApplied, favorite: favorited, status: statusOptions[status])
            jobStore.createJob(with: job)
            presentationMode.wrappedValue.dismiss()
        }
    }

    private func toggleStatusPicker() {
        withAnimation {
            statusPickerVisible.toggle()
        }
    }

    // MARK: - Body

    var errorAlert: Alert {
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
                    TextField("Title", text: $jobTitle)
                    TextField("Company", text: $jobCompany)
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
                    Toggle("Favorite", isOn: $favorited)
                }
            }
            .alert(isPresented: $errorAlertVisible) { errorAlert }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Add job")
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

// MARK: - Previews

#if DEBUG
struct JobSheetViewPreviews: PreviewProvider {
    static var previews: some View {
        JobSheetView()
    }
}
#endif
