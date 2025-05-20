//
//  msgUI.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/6/25.
//

import MessageUI
import SwiftUI

struct email: View {
    @State private var show = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State private var alertMessage: String?
    @State private var alertIsPresented: Bool = false
    var body: some View {
        Button(action: {show.toggle()}) {
            VStack {
                Text("Email us with any other questions at")
                    .font(.footnote)
                    .tint(.blue)
                    .frame(alignment: .center)
                    .padding(.vertical, 6)
            }
            .disabled(!MailView.canSendMail())
            .sheet(isPresented: $show) {
                MailView(result: $mailResult)
                    .onAppear {

                    }
                    .onDisappear {
                        if let result = mailResult {
                            switch result {
                                case .success(let mailResult):
                                    if mailResult == .sent {
                                            alertIsPresented = true
                                    }
                                case .failure(let error):
                                    alertMessage = error.localizedDescription
                            }
                        }
                    }
            }
            .alert(isPresented: $alertIsPresented) {
                Alert(title: Text("Thank you for emailing us"), message: Text("We will email you back when we can"), dismissButton: .default(Text("OK")))
            }
        }
    }
}
struct MailView: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView

        init(_ parent: MailView) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                parent.dismiss()
            }
            if let error = error {
                parent.result = .failure(error)
            } else {
                parent.result = .success(result)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(["dawgpound@d214.org"])
//        vc.setSubject("")
//        vc.setMessageBody("", isHTML: false)
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {

    }

    static func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
}
