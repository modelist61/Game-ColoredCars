//
//  CarCardView.swift
//  CollectColorOfCars
//
//  Created by Dmitry Tokarev on 08.08.2021.
//

import SwiftUI

struct CarCard: View {
    
    let car: Car
    @Binding var selectCard: Int
    @Binding var selectedColorName: String
    @Binding var total: [Color]
    
    @State private var animationToggle = true
    @State private var shadowRadius: CGFloat = 15
    @State private var timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    private var tapAnimationGesture: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                animationToggle.toggle()
                timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
                selectCard = car.id
                selectedColorName = car.colorName
                total.append(car.color)
                self.feedback.notificationOccurred(.success)
                withAnimation {
                    self.shadowRadius = 1
                }
            }
    }
    private func tapAnimationFunc() {
            if !animationToggle {
                animationToggle.toggle()
                self.shadowRadius = 15
                timer.upstream.connect().cancel()
        }
    }
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 25.0)
//                .foregroundColor(.gray)
//                .shadow(radius: 5)
//                .shadow(radius: 5)
//            Color(.black)
//                .mask(RoundedRectangle(cornerRadius: 25.0)
//                        .strokeBorder(Color.black, lineWidth: 3))
//            Image(systemName: "car")
//                .resizable()
//                .frame(width: 60, height: 50)
//                .foregroundColor(car.color)
            
//            ZStack {
//                Circle()
//                    .overlay(Circle()
//                                .stroke(Color("gradientColor1"), lineWidth: 1)
//                                .blur(radius: 2))
//                    .frame(width: 100, height: 100)
//                    .foregroundColor(Color("gradientColor1"))
//                    .shadow(color: Color("shadowColor1"), radius: 7, x: 6, y: 4)
//                    .shadow(color: Color("shadowColor2"), radius: 7, x: -4, y: -6)
//
//
//                Image(systemName: "car")
//                    .resizable()
//                    .frame(width: 60, height: 50)
////                    .foregroundColor(car.color)
//                    .foregroundColor(car.color)
//            }
            
//            ZStack {
//                LinearGradient(gradient: Gradient(colors: [Color("iconGradientColor1"), Color("iconGradientColor2")]), startPoint: .top, endPoint: .bottom)
//                    .mask(RoundedRectangle(cornerRadius: 40))
//                    .frame(width: 150, height: 150 )
//                    .shadow(color: animationToggle ? .clear : .white, radius: shadowRadius, x: 0.0, y: 0.0)
//                    .shadow(color: .gray, radius: 5, x: 3.0, y: 3.0)
//
//                LinearGradient(gradient: Gradient(colors: [Color.black, car.color, car.color]), startPoint: .bottom, endPoint: .top)
//                    .frame(width: 120, height: 120)
//                    .mask(Text(Image(systemName: "car.fill"))
//                            .font(.system(size: 80).bold()))
//                    .shadow(color: car.color == .black ? .gray : .black, radius: 2, x: 0.0, y: 0.0)
//                    .shadow(color: car.color == .black ? .gray : .black, radius: 4, x: 0.0, y: 0.0)
//
//
//            }
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .overlay(RoundedRectangle(cornerRadius: 40)
                                .stroke(Color("gradientColor1"), lineWidth: 1)
                                .blur(radius: 1))
                    .frame(width: 140, height: 140)
                    .foregroundColor(Color("gradientColor1"))
                    .shadow(color: Color("shadowColor1"), radius: 8, x: 8, y: 8)
                    .shadow(color: Color("shadowColor2"), radius: 7, x: -8, y: -8)
                    .shadow(color: animationToggle ? .clear : .white, radius: shadowRadius, x: 0.0, y: 0.0)
                
                LinearGradient(gradient: Gradient(colors: [Color.black, car.color, car.color]), startPoint: .bottom, endPoint: .top)
                                    .frame(width: 120, height: 120)
                                    .mask(Text(Image(systemName: "car.fill"))
                                            .font(.system(size: 80).bold()))
                                    .shadow(color: car.color == .black ? .gray : .black, radius: 2, x: 0.0, y: 0.0)
                                    .shadow(color: car.color == .black ? .gray : .black, radius: 4, x: 0.0, y: 0.0)
            }
        }
        
        .gesture(tapAnimationGesture)
        .onReceive(timer) { _ in
            tapAnimationFunc()
        }
    }
}

struct CarCardView_Previews: PreviewProvider {
    static var previews: some View {
        
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("gradientColor1"), Color("gradientColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                CarCard(car: Car.init(id: 1, color: .red, colorName: "white"), selectCard: .constant(1), selectedColorName: .constant(""), total: .constant([Color.black]))
            }
            }
}
