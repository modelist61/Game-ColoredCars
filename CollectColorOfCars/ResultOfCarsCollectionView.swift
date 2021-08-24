//
//  ResultOfCarsCollectionView.swift
//  CollectColorOfCars
//
//  Created by Dmitry Tokarev on 08.08.2021.
//

import SwiftUI

struct ResultOfCarsCollectionView: View {
    
    var carsCollect: [Color] = [.white, .black, .black, .red, .red]
    
    let carsCollect3 = ["white": 0,
                        "red": 0,
                        "blue": 0,
                        "black": 0,
                        "green": 0,
                        "yellow": 5]
    
//    @State var white = 0
//    @State var black = 0
//    @State var red = 0
    
//    func calcCars() -> [Int] {
//        var white = 0
//        var red = 0
//        var blue = 0
//        var black = 0
//        var gray = 0
//        var yellow = 0
//        
//        for color in carsCollect {
//            if color == .white {
//                white += 1
//            } else if color == .red {
//                red += 1
//            } else if color == .blue {
//                blue += 1
//            } else if color == .black {
//                black += 1
//            } else if color == .gray {
//                gray += 1
//            } else if color == .yellow {
//                yellow += 1
//            }
//        }
//        return [white, red, blue, black, gray, yellow]
//    }
    
    
    var body: some View {
        
        let keys = carsCollect3.map { $0.key}
        let values = carsCollect3.map {$0.value}
        
        ZStack(alignment: .leading) {
            
            VStack {
                
                ForEach(keys.indices) { index in
                    SmallCar(color: .white, totalNumber: values[index])
                }
                
                
                
            }.padding()
            
        }.frame(width: 200, alignment: .center)
        
    }
}

struct ResultOfCarsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("gradientColor1"), Color("gradientColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            ResultOfCarsCollectionView()
        }
    }
}

struct SmallCar: View {
    
    let color: Color
    let totalNumber: Int
    
    var body: some View {
        HStack {
            Image(systemName: "car")
                .resizable()
                .frame(width: 30, height: 25)
            Text(".......................")
            Text("\(totalNumber)")
        }.foregroundColor(color)
    }
}
