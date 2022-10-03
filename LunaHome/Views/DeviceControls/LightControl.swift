//
//  LightControl.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 23.08.22.
//

import SwiftUI

extension UIColor {
  var hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
    var hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) = (0, 0, 0, 0)
    self.getHue(&(hsba.h), saturation: &(hsba.s), brightness: &(hsba.b), alpha: &(hsba.a))
    return hsba
  }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

struct LightControl: View {
    @Binding var light: Light
    @State var rgb: RGB = RGB(r: 1, g: 0, b: 0)
    @State var wheelBri: CGFloat = 1
    @State var date: String = ""
    @State private var isEditing = false
    @State var brightness: Double = 1
    @State var presets: [ColorPreset] = [ColorPreset]()
    @State var selectedPreset: Int = 0
    @State var status: Bool = false
    
    
    func setup(){
        status = light.state
        brightness = Double(light.brightness)
        let colorConvert = UIColor(hue: CGFloat(light.hue)/360, saturation: CGFloat(light.saturation)/255, brightness: 1, alpha: 1)
        
        rgb = RGB(r: colorConvert.rgba.red, g: colorConvert.rgba.green, b: colorConvert.rgba.blue)
        
        presets = Presets().getPresets()
        print(presets)
    }
    
    func updateBrightness(){
        light.brightness = Int(Double(brightness))
        
        if brightness == 0{
            status = false
        }else{
            status = true
        }
    }
    
    func updateState(){
        light.state = status
    }
    
    func updateColor(){
        let convert = UIColor(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)
        light.hue = Float(convert.hsba.h*360)
        light.saturation = Float((convert.hsba.s)*255)
        
        Presets().savePreset(preset: ColorPreset(id: Int(convert.hsba.h*360), hue: convert.hsba.h*Double(360), saturation: convert.hsba.s*255, brightness: 1))
        presets = Presets().getPresets()
    }
    

//    MARK: Color Presets

var presetSelector: some View{
    ScrollView(.horizontal, showsIndicators: false){
        HStack{
            ForEach(presets){preset in
                Button(action: {
                    let colorConvert = UIColor(hue: CGFloat(preset.hue)/360, saturation: CGFloat(preset.saturation)/255, brightness: 1, alpha: 1)
                    
                    rgb = RGB(r: colorConvert.rgba.red, g: colorConvert.rgba.green, b: colorConvert.rgba.blue)
                    
                    light.hue = Float(preset.hue)
                    light.saturation = Float(preset.saturation)
                }){
                    VStack{
                        Circle()
                            .padding(5)
                            .frame(width: 55, height: 55)
                            .foregroundColor(Color(hue: preset.hue/360, saturation: preset.saturation/255, brightness: preset.brightness))
                    }.foregroundColor(.primary)
                }
            }
        }
    }
}

    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "lightbulb.fill").foregroundColor(.gray).bold()
                Text("Küchenlicht").foregroundColor(.gray).bold()

                Spacer()
            }.padding(20)
            .padding([.bottom], 40)
            

            ColorPicker(radius: 300, rgbColour: $rgb, brightness: $wheelBri, modified: $date)
            HStack{
                Spacer()

                ZStack{
                    Rectangle()
                        .foregroundColor(.secondary)
                        .cornerRadius(12)
                        .frame(width: 55, height: 30)
                        .padding()
                    Text("\(Int(brightness))%")
                        .foregroundColor(Color.white)

                }.padding([.bottom], -10)
                
                
                
                
            }
            VStack{
                
                Slider(
                    value: $brightness,
                    in: 0...100,
                    onEditingChanged: { editing in
                        isEditing = editing
                        updateBrightness()
                        updateState()
                    }
                ).tint(Color(uiColor: UIColor(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)))
                
            }.padding()

            
            
//            Rectangle()
//                .foregroundColor(Color(uiColor: UIColor(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)))
//                .frame(width: 20, height: 20)
        }.onAppear(perform: setup)
            .onChange(of: date, perform: {_ in
                updateColor()
            })
        
        HStack{
            Rectangle().foregroundColor(.teal)
                .frame(width: 10)
                .cornerRadius(12)

                
            VStack{
                HStack{
//                    Image(systemName: "lightbulb.fill")
                    Text("Details")
                    Spacer()
                }.font(.largeTitle)
                    .bold()
                    .padding([.bottom], 1)
                
                HStack{
                    Text("\(light.name)")
                    Spacer()
                }.foregroundColor(.gray)
                    .bold()
                    
                
                if status == true{
                    HStack{
                        Image(systemName: "lightbulb.fill")
                            
//                            .foregroundColor(Color(uiColor: UIColor(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)))
                        Text("on")
                        Spacer()
                    }
                }else{
                    HStack{
                        Image(systemName: "lightbulb.slash.fill")
                        Text("off")
                        Spacer()
                    }
                    
                }
                
            }
            .padding([.leading], 5)
            
            
            
        }.frame(height: 100)
            .padding()
//                .padding([.top],10)
                .padding([.bottom], 15)
        
        HStack{
            Text("Last used")
                .foregroundColor(.gray)
                    .bold()
            Spacer()
        }.padding([.leading])
        
        presetSelector
            .padding([.leading, .trailing])
       
        

        
    }
    
}

