//
//  DoorbellTile.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 13.09.22.
//

import SwiftUI
import AVKit


struct PlayerView: UIViewRepresentable {
    let feedName: String
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero, feedName: feedName)
    }
}

class LoopingPlayerUIView: UIView {
   
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    var Feed = "String"
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
  
    init(frame: CGRect, feedName: String) {
        Feed = feedName
        super.init(frame: frame)
       
        let fileUrl = Bundle.main.url(forResource: Feed, withExtension: "mp4")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.play()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct DoorbellTile: View {
    var proxy: CGSize
    @EnvironmentObject var fetcher: Fetcher
    @State var show: Bool = false
    @State var camera: Camera
//    @StateObject private var model = PlayerViewModel(fileName: "SampleVideo_720x480_20mb"
    
    
    var body: some View {
       
            MediumTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
                .overlay(
                    GeometryReader{Cproxy in
                        PlayerView(feedName: camera.feedName)
//                        Image("Doorbell")
//                            .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: Cproxy.size.width, height: Cproxy.size.height)
                                .clipped()
                                .edgesIgnoringSafeArea(.all)
                                .cornerRadius(DeviceItemCalculator().cornerRadius)
                        
                                .overlay(
                                    VStack{
                                        HStack{
                                            Text(camera.name)
                                                .font(.caption.bold())
                                                .foregroundColor(.black)
                                                .foregroundStyle(.regularMaterial)
                                                .padding(10)
                                            Spacer()
                                            Circle().frame(width: 5, height: 5)
                                                .foregroundColor(.green)
                                            Text("live")
                                                .font(.caption)
                                                .padding(.trailing)
                                                
                                        }
                                        Spacer()
                                        Button(action: {show.toggle()}){
                                            Image(systemName: "mic.fill")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(Color.accentColor)
                                                .clipShape(Circle())
                                        }
                                        .padding(.bottom, 10)
                                    }.foregroundStyle(.regularMaterial)
                                )
                    }
                )
                .padding(.bottom, DeviceItemCalculator().spacer)
                .sheet(isPresented: $show){
                    CameraControl(camera: $camera)
                }
                
    
    }
}

//struct DoorbellTile_Previews: PreviewProvider {
//    static var previews: some View {
//        DoorbellTile()
//    }
//}
