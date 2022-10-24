//
//  LunaTile.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 30.09.22.
//

import SwiftUI

struct LunaTile: View {
    var proxy: CGSize
    @EnvironmentObject var fetcher: Fetcher
    @State var showDetail: Bool = false
    @State var animate: Bool = false
    
    
    //    returns the given string separated by the first space
        func split(input: String) -> [String]{
            var cat1: String = ""
            var cat2: String = ""
            var breakReached: Bool = false
            
            for character in input{
                if breakReached{
                    cat2.append(character)
                }else if character == " "{
                    breakReached = true
                    cat2.append(character)
                }else{
                    cat1.append(character)
                }
                
            }
            return [cat1, cat2]
        }
    
    func getTip() -> LunaEntry{
        return fetcher.data.recommendations.first(where: {$0.priority == 5}) ?? fetcher.data.recommendations.first ?? LunaEntry(id: "", title: "", message: "", priority: 0, image: "", color: "")
        
    }
    var body: some View {
        Button(action: {
            showDetail.toggle()
        }){
            VStack{
                if getTip().priority < 4{
                    SmallTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
                        .overlay(
                            HStack{
                                Spacer()
//                                Image(systemName: getTip().image)
//                                    .font(.caption)
//                                    .foregroundColor(Luna().getColor(string: getTip().color))
//                                    .padding(5)
                                //                                .background(.white)
                                //                                .clipShape(Circle())
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        HStack(alignment: .top, spacing: 0
                                        ){
                                            Text(split(input: getTip().title)[0])
                                                .foregroundColor(.primary)
                                            Text(split(input: getTip().title)[1])
                                                .foregroundColor(.secondary)
                                        }
                                        .font(.body.bold())
                                        .minimumScaleFactor(0.7)
                                        
//                                        .padding(.leading, 10)
                                        
                                        Spacer()
                                    }
                                    HStack{
                                        
                                        Text("Priorität")
                                            .font(.caption.bold())
                                            .foregroundColor(.secondary)
                                        
                                        ForEach(1...5, id: \.self){prio in
                                            Circle()
                                                .frame(width: 5, height: 5)
                                                .foregroundColor(getTip().priority >= prio ? Luna().getColor(string: getTip().color) : .secondary)
                                        }
                                    }
                                    
                                    
                                }
                                Spacer()
                            }.padding(10)
                        )
                        .padding(.bottom, DeviceItemCalculator().spacer)
                }else{
                    MediumTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
                    
                        .overlay(
                            VStack(alignment: .center, spacing: 0){
                                Spacer()
                                Image(systemName: getTip().image)
                                    .font(.title2)
                                    .foregroundColor(Luna().getColor(string: getTip().color))
                                    .padding(10)
                                    .background(.white)
                                    .clipShape(Circle())
                                    .padding(.top, 10)
                                Spacer()
                                HStack{
                                    Spacer()
                                    HStack(spacing: 0){
                                        Text(split(input: getTip().title)[0])
                                            .foregroundColor(.primary)
                                        Text(split(input: getTip().title)[1])
                                            .foregroundColor(.secondary)
                                    }
                                    .font(.headline.bold())
                                    
                                    Spacer()
                                }
                                HStack{
                                    Text("Priorität")
                                        .font(.caption.bold())
                                        .foregroundColor(.secondary)
                                    ForEach(1...5, id: \.self){prio in
                                        Circle()
                                            .frame(width: 5, height: 5)
                                            .foregroundColor(getTip().priority >= prio ? Luna().getColor(string: getTip().color) : .secondary)
                                    }
                                }
                                .padding(.bottom)
                                Spacer()
                                
                            }
                                .background(
                                    VStack{
                                        Spacer()
                                        HStack{
                                            Spacer()
                                        }
                                    }
                                        .background(animate ? .red : .clear)
//
//                                        .background(
//
////                                            RadialGradient(colors: [.red, .clear], center: .center, startRadius: 100, endRadius: animate ? 50 : 200)
//                                        )
//                                        .opacity(animate ? 1 : 0)
                                        .cornerRadius(DeviceItemCalculator().cornerRadius)
                                )
                            
                        )
                        .onAppear(perform: {
                            withAnimation(.easeInOut(duration: 1).repeatForever()){
                                animate.toggle()
                                print("action")
                            }
                        })
                        .padding(.bottom, DeviceItemCalculator().spacer)
                }
            }
            
      
        }
        .sheet(isPresented: $showDetail){
            LunaTipDetail(tip: getTip())
        }
    }
}

//struct LunaTile_Previews: PreviewProvider {
//    static var previews: some View {
//        LunaTile()
//    }
//}
