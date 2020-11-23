//
//  ProfileHeader.swift
//  FitBook2
//
//  Created by BAR SEGEV on 7/17/20.
//  Copyright © 2020 BAR SEGEV. All rights reserved.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack{
            
            Color(red: 0.09, green: 0.63, blue: 0.52)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Image("ravi")
                    .resizable().aspectRatio(contentMode: .fill).frame(width: 150, height: 150).clipShape(Circle()).overlay(Circle().stroke(Color.white,lineWidth: 5))
                Text("Ravi Thakur").font(Font.custom("Pacifico-Regular", size: 35))
                
                Text("Ios Developer").font(Font.custom("Austine Demo", size: 30))
                
                Divider()
                
                infoview(text: "+9340413756", image: "phone.fill")
                
                
                
                infoview(text: "thakurravi@gmail.com", image: "envelope.fill")
                    
                Divider()
                        
                 }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct infoview: View {
    
    let text:  String
    let image: String
    
    var body: some View {
        Rectangle()
            .frame(width: 400, height: 50).cornerRadius(35).foregroundColor(.white).overlay(HStack {
                Image(systemName: image).foregroundColor(.green)
                
                Text(text).bold()
            })
            
            .padding(.all)
    }
}


