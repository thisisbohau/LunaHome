//
//  LunaTipDetail.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 07.10.22.
//

import SwiftUI

struct LunaTipDetail: View {
    @State var tip: LunaEntry
    @EnvironmentObject var fetcher: Fetcher
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func removeTip(){
        fetcher.data.recommendations.removeAll(where: {$0.id == tip.id})
        presentationMode.wrappedValue.dismiss()
    }
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
        VStack(alignment: .leading, spacing: 0){
            HStack{
                HStack(spacing: 0){
                    Text(split(input: tip.title)[0])
                    Text(split(input: tip.title)[1])
                        .foregroundColor(.secondary)
                }
                .font(.title2)
                .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: tip.image)
                    .foregroundColor(Luna().getColor(string: tip.color))
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
                        .foregroundColor(tip.priority >= prio ? Luna().getColor(string: tip.color) : .secondary)
                }
            }
            .padding(.bottom)
            
            Text(tip.message)
                .font(.body)
            Spacer()
            Text("Erledigt? Super, ich werde diese Änderungen in der nächsten Zeit an die Geräte weiterleiten. Ansonsten kannst du die Meldung auch manuell bestätigen")
                .foregroundStyle(.secondary)
                .font(.caption)
            
            Button(action: removeTip){
                HStack{
                    Spacer()
                    Text("Erledigt")
                        
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding()
                .background(Color.accentColor)
                .cornerRadius(18)
            }
            .padding(.top)
            
        }
        .padding(22)
        .background(Color("fill")
        .ignoresSafeArea())
        
//        .cornerRadius(30)
    }
}
//
//struct LunaTipDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        LunaTipDetail(tip: Fetcher().data.recommendations.first!)
//            .environmentObject(Fetcher())
//    }
//}
