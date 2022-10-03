//
//  WasherProgrammControl.swift
//  LunaHome
//
//  Created by Carina Schmidinger on 02.10.22.
//

import SwiftUI

struct WasherProgrammControl: View {
    @State var selectedStep: Int = 1
    @State var step1: Bool = true
    @State var step2: Bool = false
    
    @State private var selectedProgramm = ""
    @State private var selectedBeschmutzung = ""
    
    var programme = ["Standart", "Jeans", "Schnell", "Ultra"]
    var beschmutzung = ["Leicht", "Mittel", "Stark", "Flecken", "Ultra Schmutz"]
    
    
    var stepBar: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                
                //Schritt 1 angecklickt
                Button(action: {
                    selectedStep = 1
//                    step1 = true
//                    step2 = false
                }){
                    ZStack{
                        if selectedStep == 1{
                            Rectangle()
                                .frame(width: 85, height: 35)
                                .foregroundColor(.teal)
                                .cornerRadius(15)
                            Text("Schritt 1").foregroundColor(.white)
                        }else{
                            Rectangle()
                                .frame(width: 85, height: 35)
                                .foregroundColor(.secondary)
                                .cornerRadius(15)
                            Text("Schritt 1").foregroundColor(.white)
                        }
                        
                    }
                }
                
                    
                    
//Schritt 2
                    
                    Button(action: {
                        selectedStep = 2
//                        step1 = false
//                        step2 = true
                    }){
                        ZStack{
                            if selectedStep == 2{
                                Rectangle()
                                    .frame(width: 85, height: 35)
                                    .foregroundColor(.teal)
                                    .cornerRadius(15)
                                Text("Schritt 2").foregroundColor(.white)
                            }else{
                                Rectangle()
                                    .frame(width: 85, height: 35)
                                    .foregroundColor(.secondary)
                                    .cornerRadius(15)
                                Text("Schritt 2").foregroundColor(.white)
                            }
                            
                        }
                    }
                    
                    Button(action: {
                        selectedStep = 3
                    }){
                        ZStack{
                            Rectangle()
                                .frame(width: 85, height: 35)
                                .foregroundColor(.secondary)
                                .cornerRadius(15)
                            Text("Schritt 3").foregroundColor(.white)
                        }
                    }
                    
                    Button(action: {
                        selectedStep = 4
                    }){
                        ZStack{
                            Rectangle()
                                .frame(width: 85, height: 35)
                                .foregroundColor(.secondary)
                                .cornerRadius(15)
                            Text("Schritt 4").foregroundColor(.white)
                        }
                    }
                    
                    
                    
                    
                    
                }.padding()
                .padding([.bottom], 20)
            }
    }

    
    var step1View: some View{
        VStack{
            VStack {
                HStack{
                    Text("Waschprogramm auswählen").font(.title2).bold()
                    Spacer()
                }.padding([.leading, .bottom])
                
//                            Picker("Please choose a color", selection: $selectedProgramm) {
//                                ForEach(programme, id: \.self) {
//                                    Text($0)
//                                }
//                            }.pickerStyle(.wheel)
//                        .padding([.trailing, .leading])
                    }
            
            ForEach(programme, id: \.self){entry in
                Button(action:{
                    selectedProgramm = entry
                }){
                    HStack{
                        Image(systemName: "washer.fill")
                        Text(entry)
                            
                        Spacer()
                    }
                    .padding()
                    .background(selectedProgramm == entry ? Color.teal : Color.secondary)
                    .cornerRadius(20)
                    .padding(.bottom, 5)
                    .foregroundColor(.white)
                    
                }
                
                
                
            }.padding([.leading, .trailing])
        }
    }
    
    var step2View: some View{
        VStack{
            HStack{
                Text("Beschmutzungsgrad einstellen").font(.title2).bold()
                Spacer()
            }.padding([.leading, .bottom])
            
            ForEach(beschmutzung, id: \.self){entry2 in
                Button(action:{
                    selectedBeschmutzung = entry2
                }){
                    HStack{
                        if entry2 == "Leicht"{
                            Image(systemName: "1.circle.fill")
                        }else if entry2 == "Mittel"{
                            Image(systemName: "2.circle.fill")
                        }else if entry2 == "Stark"{
                            Image(systemName: "3.circle.fill")
                        }
                        
                        Text(entry2)
                            
                        Spacer()
                    }
                    .padding()
                    .background(selectedBeschmutzung == entry2 ? Color.teal : Color.secondary)
                    .cornerRadius(20)
                    .padding(.bottom, 5)
                    .foregroundColor(.white)
                    
                }
                
                
                
            }.padding([.leading, .trailing])
        }
    }
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Waschvorgang optimieren").font(.largeTitle).bold().padding()
                Spacer()
            }
            stepBar
            

            if selectedStep == 1{
                step1View
            }else if selectedStep == 2{
                step2View
            }
            
            Spacer()
        
            Button(action:{
                selectedStep = selectedStep + 1
            }){
                HStack{
                    Spacer()
                    Text("Weiter")
                    Spacer()
        
                }
        
            }
                .foregroundColor(.white)
        
                .padding()
                .background(.orange)
                .cornerRadius(18)
                .padding()
            }
            
            
            
            
        }
    }
    
    struct WasherProgrammControl_Previews: PreviewProvider {
        static var previews: some View {
            WasherProgrammControl()
        }
    }

