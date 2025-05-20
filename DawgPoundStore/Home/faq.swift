//
//  faq.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/20/25.
//
import SwiftUI
struct faq: View {
    let questions:Array<(String,String)> = [
        ("Where do I get my order picked up?","Answer Etc. Etc."),
        ("Is there a support email?","Answer Etc. Etc."),
        ("Where do I get my order picked up?","Answer Etc. Etc."),
        ("Where do I get my order picked up?","Answer Etc. Etc."),
        ("Where do I get my order picked up?","Answer Etc. Etc."),
        ("Where do I get my order picked up?","Answer Etc. Etc.")
    ]
    var body: some View {
//        GeometryReader { size in
            // FAQ Section
            VStack(alignment: .leading, spacing: 20) {
                Text("FAQ")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 18/*size.size.width / 8*/), count: 2), spacing: 20) {
                    ForEach(0..<questions.count, id: \.self) { index in
                        Button(action: {
                            print("FAQ \(index) tapped")
                        }) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(questions[index].0)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(questions[index].1)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.systemGray6).opacity(0.2))
                            .cornerRadius(10)

                        }
                    }
                    .padding(.horizontal)
            }
        }
    }
}
