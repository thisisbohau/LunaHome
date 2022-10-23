//
//  ColorWheel.swift
//  Home
//
//  Created by David Bohaumilitzky on 21.06.21.
//

import Foundation
import SwiftUI
import UIKit
import CoreImage

func rgbToHue(r:CGFloat,g:CGFloat,b:CGFloat) -> (h:CGFloat, s:CGFloat, b:CGFloat) {
let minV:CGFloat = CGFloat(min(r, g, b))
let maxV:CGFloat = CGFloat(max(r, g, b))
let delta:CGFloat = maxV - minV
var hue:CGFloat = 0
if delta != 0 {
if r == maxV {
   hue = (g - b) / delta
}
else if g == maxV {
   hue = 2 + (b - r) / delta
}
else {
   hue = 4 + (r - g) / delta
}
hue *= 60
if hue < 0 {
   hue += 360
}
}
let saturation = maxV == 0 ? 0 : (delta / maxV)
let brightness = maxV
return (h:hue/360, s:saturation, b:brightness)
}
    
func atan2To360(_ angle: CGFloat) -> CGFloat {
    var result = angle
    if result < 0 {
        result = (2 * CGFloat.pi) + angle
    }
    return result * 180 / CGFloat.pi
}

func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
    let xDist = a.x - b.x
    let yDist = a.y - b.y
    return CGFloat(sqrt(xDist * xDist + yDist * yDist))
}

extension CGFloat {
    func map(from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let result = ((self - from.lowerBound) / (from.upperBound - from.lowerBound)) * (to.upperBound - to.lowerBound) + to.lowerBound
        return result
    }
}


/// This UIViewRepresentable uses `CIHueSaturationValueGradient` to draw a circular gradient with the RGB colour space as a CIFilter.
struct CIHueSaturationValueGradientView: UIViewRepresentable {
    
    /// Radius to draw
    var radius: CGFloat
    
    /// The brightness/value of the wheel.
    @Binding var brightness: CGFloat
    
    /// Image view that will hold the rendered CIHueSaturationValueGradient.
    let imageView = UIImageView()
    
    func makeUIView(context: Context) -> UIImageView {
        /// Render CIHueSaturationValueGradient and set it to the ImageView that will be returned.
        imageView.image = renderFilter()
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        /// When the view updates eg. brightness changes, a new CIHueSaturationValueGradient will be generated.
        uiView.image = renderFilter()
    }
    
    /// Generate the CIHueSaturationValueGradient and output it as a UIImage.
    func renderFilter() -> UIImage {
        let filter = CIFilter(name: "CIHueSaturationValueGradient", parameters: [
            "inputColorSpace": CGColorSpaceCreateDeviceRGB(),
            "inputDither": 0,
            "inputRadius": radius * 0.4,
            "inputSoftness": 0,
            "inputValue": brightness
        ])!
        
        /// Output as UIImageView
        let image = UIImage(ciImage: filter.outputImage!)
        return image
    }
}

struct CIHueSaturationValueGradientView_Previews: PreviewProvider {
    static var previews: some View {
        CIHueSaturationValueGradientView(radius: 350, brightness: .constant(1))
            .frame(width: 350, height: 350)
    }
}


/// Struct that holds red, green and blue values. Also has a `hsv` value that converts it's values to hsv.
struct RGB {

    var r: CGFloat // Percent [0,1]
    var g: CGFloat // Percent [0,1]
    var b: CGFloat // Percent [0,1]
    
    static func toHSV(r: CGFloat, g: CGFloat, b: CGFloat) -> HSV {
        let min = r < g ? (r < b ? r : b) : (g < b ? g : b)
        let max = r > g ? (r > b ? r : b) : (g > b ? g : b)
        
        let v = max
        let delta = max - min
        
        guard delta > 0.00001 else { return HSV(h: 0, s: 0, v: max) }
        guard max > 0 else { return HSV(h: -1, s: 0, v: v) } // Undefined, achromatic grey
        let s = delta / max
        
        let hue: (CGFloat, CGFloat) -> CGFloat = { max, delta -> CGFloat in
            if r == max { return (g-b)/delta } // between yellow & magenta
            else if g == max { return 2 + (b-r)/delta } // between cyan & yellow
            else { return 4 + (r-g)/delta } // between magenta & cyan
        }
        
        let h = hue(max, delta) * 60 // In degrees
        
        return HSV(h: (h < 0 ? h+360 : h) , s: s, v: v)
    }
    
    var hsv: HSV {
        return RGB.toHSV(r: self.r, g: self.g, b: self.b)
    }
}

/// Struct that holds hue, saturation, value values. Also has a `rgb` value that converts it's values to hsv.
struct HSV {
    var h: CGFloat // Angle in degrees [0,360] or -1 as Undefined
    var s: CGFloat // Percent [0,1]
    var v: CGFloat // Percent [0,1]
    
    static func toRGB(h: CGFloat, s: CGFloat, v: CGFloat) -> RGB {
        if s == 0 { return RGB(r: v, g: v, b: v) } // Achromatic grey
        
        let angle = (h >= 360 ? 0 : h)
        let sector = angle / 60 // Sector
        let i = floor(sector)
        let f = sector - i // Factorial part of h
        
        let p = v * (1 - s)
        let q = v * (1 - (s * f))
        let t = v * (1 - (s * (1 - f)))
        
        switch(i) {
        case 0:
            return RGB(r: v, g: t, b: p)
        case 1:
            return RGB(r: q, g: v, b: p)
        case 2:
            return RGB(r: p, g: v, b: t)
        case 3:
            return RGB(r: p, g: q, b: v)
        case 4:
            return RGB(r: t, g: p, b: v)
        default:
            return RGB(r: v, g: p, b: q)
        }
    }
    
    var rgb: RGB {
        return HSV.toRGB(h: self.h, s: self.s, v: self.v)
    }
    
}

struct ColorWheel: View {

    var radius: CGFloat
    @Binding var rgbColour: RGB
    @Binding var brightness: CGFloat
    @State var knobSize : CGFloat = 25
    
    var body: some View {
        /*
        DispatchQueue.main.async {
            self.rgbColour = HSV(h: self.rgbColour.hsv.h, s: self.rgbColour.hsv.s, v: self.brightness).rgb
        }*/
        
        /// Geometry reader so we can know more about the geometry around and within the view.
        return GeometryReader { geometry in
            ZStack {
                
                /// The colour wheel. See the definition.
                CIHueSaturationValueGradientView(radius: self.radius, brightness: self.$brightness)
                    /// Smoothing out of the colours.
                    .blur(radius: 10)
                    /// The outline.
                    .overlay(
                        Circle()
                            .size(CGSize(width: self.radius, height: self.radius))
                            .stroke(Color.clear, lineWidth: 10)
                            /// Inner shadow.
                          
                    )
                    /// Clip inner shadow.
                    .clipShape(
                        Circle()
                            .size(CGSize(width: self.radius, height: self.radius))
                    )
                    /// Outer shadow.
                    
                
                /// This is not required and actually makes the gradient less "accurate" but looks nicer. It's basically just a white radial gradient that blends the colours together nicer. We also slowly dissolve it as the brightness/value goes down.
                RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0.8*Double(self.brightness)), .clear]), center: .center, startRadius: 0, endRadius: self.radius/2 - 10)
                    .blendMode(.screen)
                    
                
                /// The little knob that shows selected colour.
                Circle()
                    .frame(width: knobSize, height: knobSize)
                    .offset(x: (self.radius/2 - 10) * self.rgbColour.hsv.s)
                    .rotationEffect(.degrees(-Double(self.rgbColour.hsv.h)))
                    .foregroundColor(Color.init(red: Double(self.rgbColour.r-0.08), green: Double(self.rgbColour.g-0.08), blue: Double(self.rgbColour.b-0.08)))
                
            }
            /// The gesture so we can detect touches on the wheel.
            
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged{ value in
                       
                        
                        /// Work out angle which will be the hue.
                        let y = geometry.frame(in: .global).midY - value.location.y
                        let x = value.location.x - geometry.frame(in: .global).midX
                        
                        /// Use `atan2` to get the angle from the center point then convert than into a 360 value with custom function(find it in helpers).
                        let hue = atan2To360(atan2(y, x))
                        
                        /// Work out distance from the center point which will be the saturation.
                        let center = CGPoint(x: geometry.frame(in: .global).midX, y: geometry.frame(in: .global).midY)
                        
                        /// Maximum value of sat is 1 so we find the smallest of 1 and the distance.
                        let saturation = min(distance(center, value.location)/(self.radius/2), 1)
                        
                        /// Convert HSV to RGB and set the colour which will notify the views.
                        self.rgbColour = HSV(h: hue, s: saturation, v: self.brightness).rgb
                    }
            )
        }
        /// Set the size.
        .frame(width: self.radius, height: self.radius)
    }
}


struct ColorPicker: View {
    var radius: CGFloat
    @Binding var rgbColour: RGB
    @Binding var brightness: CGFloat
    @Binding var modified: String
    
    var body: some View {
        
        DispatchQueue.main.async {
            self.rgbColour = HSV(h: self.rgbColour.hsv.h, s: self.rgbColour.hsv.s, v: self.brightness).rgb
        }
        
        return GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [
                            Color(hue: 1.0, saturation: 1.0, brightness: 0.9),
                            Color(hue: 0.9, saturation: 1.0, brightness: 0.9),
                            Color(hue: 0.8, saturation: 1.0, brightness: 0.9),
                            Color(hue: 0.7, saturation: 1.0, brightness: 0.9),
                            Color(hue: 0.6, saturation: 1.0, brightness: 0.9),
                            Color(hue: 0.5, saturation: 1.0, brightness: 0.9),
                            Color(hue: 0.4, saturation: 1.0, brightness: 0.9),
                            Color(hue: 0.3, saturation: 1.0, brightness: 0.9),
                            Color(hue: 0.2, saturation: 1.0, brightness: 0.9),
                            Color(hue: 0.1, saturation: 1.0, brightness: 0.9)
                            
                        ]), center: .center)
                    )
                    .blur(radius: 12)
                    .frame(width: radius, height: radius)
                
                    .rotationEffect(Angle(degrees: -20))
                
                RadialGradient(gradient: Gradient(colors: [Color.white, .clear]), center: .center, startRadius: 0, endRadius: self.radius)
                    .blendMode(.screen)
                
                    .clipShape(
                        Circle()
                            .size(CGSize(width: self.radius, height: self.radius))
                    )
                
                Circle()
                    .frame(width: 10, height: 10)
                    .offset(x: (self.radius/2 - 10) * self.rgbColour.hsv.s)
                    .rotationEffect(.degrees(-Double(self.rgbColour.hsv.h)))
                
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in
                        
                        let y = geometry.frame(in: .global).midY - value.location.y
                        let x = value.location.x - geometry.frame(in: .global).midX
                        
                        let hue = atan2To360(atan2(y, x))
                        
                        let center = CGPoint(x: geometry.frame(in: .global).midX, y: geometry.frame(in: .global).midY)
                        
                        let saturation = min(distance(center, value.location)/(self.radius/2), 1)
                        
                        self.rgbColour = HSV(h: hue, s: saturation, v: self.brightness).rgb
                        modified = Date().timeIntervalSince1970.description
                    }
            )
        }
        .frame(width: self.radius, height: self.radius)
    }
}

struct SmartToggleSwitch: View {
    @Binding var active: Bool
    var sliderHeight: CGFloat
    var sliderWidth: CGFloat
    var onColor: Color
    var onIcon: AnyView
    var offIcon: AnyView
    
    @State var sliderOffset: CGFloat = 0
    
    func setup(){
        if active{
            sliderOffset = 0
        }else{
            sliderOffset = sliderHeight/2
        }
        
    }
    
    var onToggle: some View{
        HStack{
            Spacer()
            VStack{
                Spacer()
                onIcon
                Spacer()
            }
            Spacer()
        }
        .background(onColor)
        .cornerRadius(36)
        .padding()
    }
    var offToggle: some View{
        HStack{
            Spacer()
            VStack{
                Spacer()
                offIcon
                Spacer()
            }
            Spacer()
        }
        .background(Color.gray)
        .cornerRadius(36)
        .padding()
    }
    
    var body: some View {
        GeometryReader{proxy in
            VStack{
                HStack{
                    Spacer()
                }
                Spacer()
            }
            .frame(height: sliderHeight)
            .background(.regularMaterial)
            .cornerRadius(50)
            
            VStack{
                if active{
                    onToggle
                }else{
                    offToggle
                }
            }
            .animation(.linear(duration: 0.1), value: active)
            .frame(height: (sliderHeight/2))
            
            .offset(y: sliderOffset)
            .gesture(DragGesture(minimumDistance: 5)
                .onChanged({location in
                    let calcOffset = location.location.y
                    let tresh = sliderHeight/2
                    if calcOffset > tresh{
                        sliderOffset = tresh
                    }else if calcOffset < 0{
                        sliderOffset = 0
                    }else{
                        sliderOffset = calcOffset
                    }
                
                if calcOffset > sliderHeight/2*0.5{
                        active = false
                    }else{
                        active = true
                    }
                
                })
                .onEnded({location in
                withAnimation(.linear(duration: 0.1)){
                    let calcOffset = location.location.y
                    let tresh = sliderHeight/2
                    if calcOffset > sliderHeight/2*0.5{
                        sliderOffset = tresh
                        active = false
                    }else{
                        sliderOffset = 0
                        active = true
                    }
                }
                    
                })
            )
            .onChange(of: active, perform: {_ in setup()})
            .onAppear(perform: {
                setup()
            })
        }
        .frame(width: sliderWidth, height: sliderHeight)
    }
}

struct VerticalSlider: View {
    var size: CGSize
    @Binding var value: Float
    @Binding var lineColor: Color
    @State var floatValue: Float = 0
    
    var onChange: () -> Void
    
    func update(){
        var updateNeeded = false
        if value.rounded().distance(to: floatValue.rounded()) > 0.3 || value.rounded().distance(to: floatValue.rounded()) < -0.3{
            updateNeeded = true
        }
        value = floatValue.rounded()
        if updateNeeded{
            onChange()
            print("change \(value)")
        }
        
            
    }

    func setup(){
        floatValue = value
    }
    var body: some View {
        VStack{
            HStack{
                GeometryReader { geometry in
                    VStack{
                        Spacer()
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .foregroundColor(Color.gray.opacity(0.3))
                                Rectangle()
                                    .foregroundColor(lineColor)
                                    .frame(width: geometry.size.width * CGFloat((floatValue != 0 ? floatValue : 1)/100))
                            }
                            .frame(width: size.width, height: size.height)
                            .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ value in
                                
                                self.floatValue = min(max(0, Float(value.location.x / geometry.size.width * 100)), 100)
                                
                                update()
                            })
                            .onEnded({value in
                                update()
                            }))
                        Spacer()
                    }.frame(width: size.width, height: size.height)
                }
            }.frame(width: size.width, height: size.height)
        }.frame(width: size.width, height: size.height)
            .onAppear(perform: setup)
            .onChange(of: value, perform: {value in setup()})
    }
}

struct ColorPreset: Identifiable, Codable{
    var id: Int
    var hue: CGFloat
    var saturation: CGFloat
    var brightness: CGFloat
}

class Presets{
    func getPresets() -> [ColorPreset]{
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        guard let data = UserDefaults.standard.data(forKey: "lastColors") else {
            let standard = [ColorPreset]()
            
            UserDefaults.standard.set(try! encoder.encode(standard) , forKey: "lastColors")
                return [ColorPreset]()
            }
        
        return (try! decoder.decode([ColorPreset].self, from: data))
        
    }
    
    func savePreset(preset: ColorPreset){
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        guard let data = UserDefaults.standard.data(forKey: "lastColors") else {
            let standard = [ColorPreset]()
            
            UserDefaults.standard.set(try! encoder.encode(standard) , forKey: "lastColors")
                return
            }
        var presets = try! decoder.decode([ColorPreset].self, from: data)
        
        presets.insert(preset, at: 0)
        
        let newData = try! encoder.encode(presets)
        UserDefaults.standard.set(newData, forKey: "lastColors")
 
    }
}

