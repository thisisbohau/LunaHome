//
//  LunaPredictions.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 27.08.22.
//

import SwiftUI
import Charts

struct LunaPredictions: View {
    var prediction: Prediction
    
    func getAvg() -> Float{
        let sum = prediction.data.compactMap({$0.value}).reduce(0, +)
        return sum/Float(prediction.data.count)
    }
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(prediction.title)
                    .font(.title.bold())
            }
            if prediction.predictable{
                HStack{
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                    Text("Prognose verfügbar")
                }
                .padding(.bottom, 10)
                
                Chart {
                    ForEach(prediction.data) { point in
                        if prediction.diagramType == 1{
                            BarMark(x: .value("", point.title),
                                    y: .value("", point.value),
                                    width: 20
                            )
                            .cornerRadius(18)
                        }else{
                            LineMark(x: .value("", point.title),
                                    y: .value("", point.value)
                            )
                            .cornerRadius(18)
                        }
                        
                    }
                }.frame(width: 300, height: 300)
                
                Text(String(format: "ø%.1f", Double(getAvg())))
                    .font(.title.bold())
                Text(prediction.averageUnit)
                    .foregroundColor(.secondary)
                    .font(.title2.bold())
                
                Text(prediction.description)
                    .padding(.top, 10)
            }else{
                HStack{
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.pink)
                    Text("Keine Prognose verfügbar")
                }
                .padding(.bottom, 10)
                
                Text("Ich konnte leider keine Prognose erstellen, da die Daten noch nicht ausreichen, um ein genaues Ergebnis zu liefern. Das tut mir leid.")
                    .padding(.top, 10)
            }
            
      
        }
        .padding(22)
        .background(Color("fill"))
        .cornerRadius(30)
    }
}

struct LunaPredictions_Previews: PreviewProvider {
    static var previews: some View {
        LunaPredictions(prediction: Prediction(id: "1", title: "Haustüre", predictable: true, data: [DataPoint(id: "1", value: 10, title: "di"), DataPoint(id: "2", value: 30, title: "Mo")], description: "h", averageUnit: "h", diagramType: 0))
    }
}
