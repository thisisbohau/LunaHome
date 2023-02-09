//
//  LunaTips.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 27.08.22.
//

import SwiftUI

struct LunaTips: View {
    @EnvironmentObject var fetcher: Fetcher
    @State var show: Bool = false
    
//    @State var fetcher.data.recommendations: [LunaEntry] = [LunaEntry(id: "1", title: "Filter Reinigen", message: "Da dein Luftreiniger in letzter Zeit viel gearbeitet hat, empfehle ich dir den Filter zu reinigen.", priority: 2, image: "aqi.high", color: "orange"), LunaEntry(id: "2", title: "Haustüre Blockiert", message: "Achtung. Eine blockierte Türe kann nicht mehr korrekt schließen. Ich habe alle Kameras auf den Eingangsbereich gerichtet, um diesen gegen Einbrüche zu sichern.", priority: 5, image: "door.left.hand.open", color: "pink")]
    
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
        
    
    var body: some View {
        if fetcher.data.recommendations.isEmpty{
            Text("Super :) Alles ist bestens. ")
                .bold()
                .padding()
        }else{
            ForEach(fetcher.data.recommendations){entry in
                Button(action: {show.toggle()}){
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            HStack(spacing: 0){
                                Text(split(input: entry.title)[0])
                                    .foregroundColor(.primary)
                                Text(split(input: entry.title)[1])
                                    .foregroundColor(.secondary)
                            }
                            .font(.title2.bold())
                            
                            
                            Spacer()
                            
                            Image(systemName: entry.image)
                                .foregroundColor(Luna().getColor(string: entry.color))
                                .padding(10)
                                .background(.white)
                                .clipShape(Circle())
                        }
                        HStack{
                            Text("Priorität")
                                .font(.caption.bold())
                                .foregroundColor(.secondary)
                            
                            ForEach(1...5, id: \.self){prio in
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(entry.priority >= prio ? Luna().getColor(string: entry.color) : .secondary)
                            }
                        }
                        .padding(.bottom)
                        
                        Text(entry.message)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                    }
                }
                .padding(22)
                .background(Color("fill"))
                .cornerRadius(30)
                .sheet(isPresented: $show){
                    LunaTipDetail(tip: entry)
                }
            }
        }
    }
}

struct LunaTips_Previews: PreviewProvider {
    static var previews: some View {
        LunaTips()
    }
}
