//
//  WasherProgrammControl.swift
//  LunaHome
//
//  Created by Carina Schmidinger on 02.10.22.
//

import SwiftUI

struct WasherProgrammControl: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var fetcher: Fetcher
    
    @State var selectedStep: Int = 1
    @State var step1: Bool = true
    @State var step2: Bool = false
    
    @State var selectedProgramm = "Standard"
    @State var selectedBeschmutzung = "Mittel"
    @State var selectedTemperatur = "30°"
    @State var selectedSchleudern = "1200"
    
    
    var programme = ["Standard", "Jeans", "Schnell", "Ultra"]
    var beschmutzung = ["Leicht", "Mittel", "Stark", "Flecken", "Ultra Schmutz"]
    var temperatur = ["30°", "40°", "60°", "90°"]
    var schleuderOptionen = ["300", "600", "1200", "1400"]
    
    
    func start(){
        fetcher.data.washer.state = true
        fetcher.data.washer.programm = selectedProgramm
        fetcher.data.washer.beschmutzung = selectedBeschmutzung
        fetcher.data.washer.temperatur = selectedTemperatur
        fetcher.data.washer.schleudern = selectedSchleudern
        
        presentationMode.wrappedValue.dismiss()
    }
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
                            if selectedStep == 3{
                                Rectangle()
                                    .frame(width: 85, height: 35)
                                    .foregroundColor(.teal)
                                    .cornerRadius(15)
                                Text("Schritt 3").foregroundColor(.white)
                            }else{
                                Rectangle()
                                    .frame(width: 85, height: 35)
                                    .foregroundColor(.secondary)
                                    .cornerRadius(15)
                                Text("Schritt 3").foregroundColor(.white)
                            }
                        }
                    }
                    
                    Button(action: {
                        selectedStep = 4
                    }){
                        ZStack{
                            if selectedStep == 4{
                                Rectangle()
                                    .frame(width: 85, height: 35)
                                    .foregroundColor(.teal)
                                    .cornerRadius(15)
                                Text("Schritt 4").foregroundColor(.white)
                            }else{
                                Rectangle()
                                    .frame(width: 85, height: 35)
                                    .foregroundColor(.secondary)
                                    .cornerRadius(15)
                                Text("Schritt 4").foregroundColor(.white)
                            }
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
                        }else if entry2 == "Flecken"{
                            Image(systemName: "wand.and.stars.inverse")
                        }else if entry2 == "Ultra Schmutz"{
                            Image(systemName: "bolt.circle.fill")
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
    
    var step3View: some View{
        VStack {
            HStack{
                Text("Temperatur auswählen").font(.title2).bold()
                Spacer()
            }.padding([.leading, .bottom])
            
            HStack{
                ForEach(temperatur, id: \.self){entry3 in
                    Button(action:{
                        selectedTemperatur = entry3
                    }){
                        HStack{
                            ZStack{
                                Circle().frame(width: 68).foregroundColor(selectedTemperatur == entry3 ? Color.teal : Color.secondary)
                                Text(entry3)
                            }
                            
                        }

//                        .background(selectedTemperatur == entry3 ? Color.teal : Color.secondary)
                        .foregroundColor(.white)
                        
                    }
                    
                    
                    
                }.padding([.leading, .trailing, .bottom])
            }
            
            HStack{
                Text("Schleuder Optionen").font(.title2).bold()
                Spacer()
            }.padding([.leading, .bottom])
                .padding([.top], 30)
            
            ForEach(schleuderOptionen, id: \.self){entry4 in
                Button(action:{
                    selectedSchleudern = entry4
                }){
                    HStack{
                        Image(systemName: "washer.fill")
                        Text(entry4)
                            
                        Spacer()
                    }
                    .padding()
                    .background(selectedSchleudern == entry4 ? Color.teal : Color.secondary)
                    .cornerRadius(20)
                    .padding(.bottom, 5)
                    .foregroundColor(.white)
                    
                }
                
                
                
            }.padding([.leading, .trailing])
            
            
            
                }
    }
    
    var step4View: some View{
        VStack{
            HStack{
                Text("Auswahl abschließen").font(.title2).bold()
                Spacer()
            }.padding([.bottom])

            HStack{
                Text("gewähltes Programm").bold().font(.headline)
                Spacer()
            }

            HStack{
                
                Image(systemName: "washer.fill")
                Text(selectedProgramm)
                    
                Spacer()
            }
            .padding()
            .background(Color.teal)
            .cornerRadius(20)
            .padding(.bottom, 20)
            .foregroundColor(.white)
            
            HStack{
                Text("gewählte Beschmutzung").bold().font(.headline)
                Spacer()
            }
            
            
            HStack{
                Image(systemName: "wand.and.stars.inverse")
                Text(selectedBeschmutzung)
                    
                Spacer()
            }
            .padding()
            .background(Color.teal)
            .cornerRadius(20)
            .padding(.bottom, 20)
            .foregroundColor(.white)
            
            HStack{
                Text("gewählte Temperatur").bold().font(.headline)
                Spacer()
            }
            
            
            HStack{
                Image(systemName: "wand.and.stars.inverse")
                Text(selectedTemperatur)
                    
                Spacer()
            }
            .padding()
            .background(Color.teal)
            .cornerRadius(20)
            .padding(.bottom, 5)
            .foregroundColor(.white)
            
            
            HStack{
                Text("gewähltes Schleudern").bold().font(.headline)
                Spacer()
            }
            
            
            HStack{
                Image(systemName: "wand.and.stars.inverse")
                Text(selectedSchleudern)
                    
                Spacer()
            }
            .padding()
            .background(Color.teal)
            .cornerRadius(20)
            .padding(.bottom, 5)
            .foregroundColor(.white)
            
        }.padding()
        
        
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
            }else if selectedStep == 3{
                step3View
            }else if selectedStep == 4{
                step4View
            }
            
            Spacer()
        
            if selectedStep > 3{
                Button(action:{
                    start()
                    

                }){
                    HStack{
                        Spacer()
                        Text("Waschvorgang starten")
                        Spacer()
            
                    }
            
                }
                    .foregroundColor(.white)
            
                    .padding()
                    .background(.orange)
                    .cornerRadius(18)
                    .padding()
            }else{
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
    }
    
    struct WasherProgrammControl_Previews: PreviewProvider {
        static var previews: some View {
            WasherProgrammControl()
        }
    }

