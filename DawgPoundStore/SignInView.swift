
import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    HStack(spacing: geometry.size.width * 0.05) {
                        
                        VStack(alignment: .leading, spacing: geometry.size.height * 0.02) {
                            Text("Get it at")
                                .font(.system(size: geometry.size.width * 0.03, weight: .medium))
                                .foregroundColor(.white)
                            
                            Text("The\nPound.")
                                .font(.system(size: geometry.size.width * 0.1, weight: .bold))
                                .foregroundColor(.orange)
                                .lineSpacing(8)
                            
                            Text("All of Hersey’s merch in one.")
                                .font(.system(size: geometry.size.width * 0.02))
                                .foregroundColor(.white)
                                .opacity(0.8)
                        }
                        .frame(width: geometry.size.width * 0.4, alignment: .leading)
                        .padding(.leading, geometry.size.width * 0.05)
                        
                        
                        Rectangle()
                            .frame(width: 1, height: geometry.size.height * 0.5)
                            .foregroundColor(.gray.opacity(0.5))
                        
                        
                        VStack(alignment: .leading, spacing: geometry.size.height * 0.03) {
                            Text("Sign in")
                                .font(.system(size: geometry.size.width * 0.04, weight: .bold))
                                .foregroundColor(.white)
                            
                            // Username Field
                            InputField(icon: "person", placeholder: "Enter your username", geometry: geometry)
                            
                            // Password Field
                            InputField(icon: "lock", placeholder: "Enter your password", geometry: geometry)
                            
                            // Sign Up Text
                            HStack(spacing: 2) {
                                Text("or")
                                    .font(.system(size: geometry.size.width * 0.018))
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Text("sign up.")
                                    .font(.system(size: geometry.size.width * 0.018))
                                    .foregroundColor(.orange)
                                    .underline()
                            }
                            
                            // Go Button
                            Button(action: {
                                // Action here
                            }) {
                                Text("Go")
                                    .font(.system(size: geometry.size.width * 0.035, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, geometry.size.height * 0.015)
                                    .background(Color.orange)
                                    .cornerRadius(15)
                            }
                            .frame(width: geometry.size.width * 0.15)
                            .padding(.top, geometry.size.height * 0.01)
                        }
                        .frame(width: geometry.size.width * 0.4)
                        .padding(.trailing, geometry.size.width * 0.05)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    
    struct InputField: View {
        var icon: String
        var placeholder: String
        var geometry: GeometryProxy
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.leading, geometry.size.width * 0.01)
                
                Text(placeholder)
                    .font(.system(size: geometry.size.width * 0.02))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.leading, 5)
                
                Spacer()
            }
            .frame(height: geometry.size.height * 0.06)
            .background(Color.black.opacity(0.3))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .cornerRadius(15)
        }
    }
}

func customColors() -> [String: Color] {
    return [
        "orange": Color(red: 255.0 / 255.0, green: 103.0 / 255.0, blue: 29.0 / 255.0),
        "brown": Color(red: 52.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0),
        "darkGray": Color(red: 126.0 / 255.0, green: 126.0 / 255.0, blue: 126.0 / 255.0),
        "lightGray": Color(red: 138.0 / 255.0, green: 138.0 / 255.0, blue: 138.0 / 255.0),
        "lightLightGray": Color(red: 217.0 / 255.0, green: 217.0 / 255.0, blue: 217.0 / 255.0)
    ]
}

#Preview {
    SignInView()
}
