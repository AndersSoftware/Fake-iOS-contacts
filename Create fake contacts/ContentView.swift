//
//  ContentView.swift
//  Create fake contacts
//
//  Created by Anders Jensen on 05/01/2024.
//

import SwiftUI
import Contacts

struct ContentView: View {
    @State var howManyContacts: String = ""
    @State var isError: Bool = false
    @State var isWorking: Bool = false
    @State var isShowingDone: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Number of contacts to create", text: $howManyContacts)
                    .keyboardType(.numberPad)
                    .border(.black)
                    .padding()
                
                if isError {
                    Text("You can only use int.")
                        .tint(.red)
                }
                
                if isShowingDone {
                    Text("You created \(howManyContacts) contacts to the phonebook.")
                }

                Button {
                    isWorking = true
                    isError = false
                    if let passedInteger = NumberFormatter().number(from: howManyContacts) {
                        Task {
                            //await createContacts(passedInteger.intValue)
                        }
                    } else {
                        isError = true
                        isWorking = false
                    }
                }label: {
                    Text("Create contacts")
                }
                .buttonStyle(.borderedProminent)
                .disabled(isWorking)
            }
            .padding()
        }
    }
    
    func randomString(_ length: Int) -> String {
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func randomNumber(_ length: Int) -> String {
        let letters = "0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func createContacts(_ howManyToCreate: Int) async {

        for _ in 1...howManyToCreate {
            var contactToCreate: CNMutableContact = CNMutableContact()
            
            contactToCreate.givenName = randomString(5)
            contactToCreate.familyName = randomString(5)
            
            contactToCreate.phoneNumbers.append(CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: randomNumber(8)) ))
            let store = CNContactStore()
            let saveRequest = CNSaveRequest()
            
            saveRequest.add(contactToCreate, toContainerWithIdentifier:nil)
            try! store.execute(saveRequest)
        }
        
        isWorking = false
    }
}

#Preview {
    ContentView()
}
