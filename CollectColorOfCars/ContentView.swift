//
//  ContentView.swift
//  CollectColorOfCars
//
//  Created by Dmitry Tokarev on 30.07.2021.
//

import SwiftUI

struct Car: Identifiable {
    var id: Int
    var color: Color
    var colorName: String
}

struct ContentView: View {
    
    let phoneBackground = LinearGradient(gradient: Gradient(colors: [Color("gradientColor1"), Color("gradientColor1"), Color("gradientColor1"), Color("gradientColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
        
    
    let cars: [Car] = [
        Car(id: 0, color: .white, colorName: "white"),
        Car(id: 1, color: .red, colorName: "red"),
        Car(id: 2, color: .blue, colorName: "blue"),
        Car(id: 3, color: .black, colorName: "black"),
        Car(id: 4, color: .gray, colorName: "gray"),
        Car(id: 5, color: .yellow, colorName: "yellow")
    ]
    
    @State private var selected = 0
    @State private var selectedColorName = "NoN"
    @State private var totalCard: [Color] = []
    
    @State private var showTotalResult = true
    
    func calcCars() -> [Int] {
        var white = 0
        var red = 0
        var blue = 0
        var black = 0
        var gray = 0
        var yellow = 0
        
        for color in totalCard {
            switch color {
            case .white: white += 1
            case .red: red += 1
            case .blue: blue += 1
            case .black: black += 1
            case .gray: gray += 1
            case .yellow: yellow += 1
            default:
                break
            }
        }
        
        
        return [white, red, blue, black, gray, yellow]
    }
    
    let columns = [GridItem(.fixed(CGFloat(140)), spacing: 20), GridItem(.fixed(CGFloat(140)), spacing: 0)]
    
    var body: some View {
        
        ZStack {
            phoneBackground
                .ignoresSafeArea()
            
            VStack {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(cars, id: \.id) { car in
                        CarCard(car: car, selectCard: $selected, selectedColorName: $selectedColorName, total: $totalCard)
                    }
                }.disabled(showTotalResult != true)
                .blur(radius: showTotalResult ? 0 : 8)
                .animation(.easeInOut)
                
                //            ForEach(totalCard, id: \.self) { name in
                //                Text("\(name)")
                //            }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("gradientColor1"), lineWidth: 1)
                                    .blur(radius: 1))
                        .frame(width: 300, height: 60)
                        .foregroundColor(Color("gradientColor1"))
                        .shadow(color: Color("shadowColor1"), radius: 8, x: 8, y: 8)
                        .shadow(color: Color("shadowColor2"), radius: 7, x: -8, y: -8)
//                        .shadow(color: animationToggle ? .clear : .white, radius: shadowRadius, x: 0.0, y: 0.0)
                    
                    Text(showTotalResult ? "Finish" : "Restart")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 0.5)
                }.padding(20)
                .onTapGesture {
                    if showTotalResult {
                        showTotalResult.toggle()
                    } else {
                        totalCard.removeAll()
                        showTotalResult.toggle()
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color("gradientColor1"), lineWidth: 1)
                                    .blur(radius: 1))
                        .frame(width: 300, height: 220)
                        .foregroundColor(Color("gradientColor1"))
                        .shadow(color: Color("shadowColor1"), radius: 8, x: 8, y: 8)
                        .shadow(color: Color("shadowColor2"), radius: 7, x: -8, y: -8)
                    
                    VStack(spacing: 40) {
                        Text("Total clicked: \(totalCard.count)")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .shadow(color: .black, radius: 1.0)
                            .frame(width: 230, alignment: .leading)
//                        Text("Selected: \(selected)")
//                        Text("Color name: \(selectedColorName)")
                        
                        
                        LazyHGrid(rows: [GridItem(.fixed(45)), GridItem(.fixed(45))], spacing: 0) {
                            ForEach(cars, id: \.id) { car in
                                HStack(spacing: 3) {
                                    Text(Image(systemName: "car.2.fill"))
                                        .foregroundColor(car.color)
                                        .shadow(color: car.color == .black ? .gray : .black, radius: 0.8, x: 0.0, y: 0.0)
                                        
                                    Text("x \(calcCars()[car.id])")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .shadow(color: .black, radius: 0.5, x: 0.0, y: 0.0)
                                }.font(.system(size: 23))
                                .frame(width: 95, alignment: .leading)
                            }
                        }
                    }.frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }.blur(radius: showTotalResult ? 8 : 0)
                .animation(.easeInOut)
                
//                ZStack {
//                    Rectangle().ignoresSafeArea(.all, edges: .bottom)
//                        .foregroundColor(Color("gradientColor1"))
//                        .opacity(0.3)
//                        .frame(height: 30, alignment: .center)
//                        .shadow(color: Color("shadowColor1"), radius: 4, x: -8, y: -8)
//                    HStack {
//                        ForEach(totalCard, id: \.self) { car in
//                            Image(systemName: "car")
//                                .ignoresSafeArea()
////                                .frame(width: 50, height: 50)
//                                .foregroundColor(car)
//                        }
//                    }
//
//                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
