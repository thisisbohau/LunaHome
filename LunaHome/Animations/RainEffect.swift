//
//  RainEffect.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 09.09.22.
//

import SwiftUI
import SpriteKit

class RainLightningScene: SKScene {

    static var shared = RainLightningScene()

    let rainEmitter = SKEmitterNode(fileNamed: "Rain.sks")!

    override func didMove(to view: SKView) {
        
        self.view?.allowsTransparency = true
        self.addChild(rainEmitter)

        rainEmitter.position.y = self.frame.maxY
        rainEmitter.particlePositionRange.dx = self.frame.width * 2.5
        
    }

}


struct RainEffect: View {
    
    var rainLightningScene: SKScene {
        let scene = RainLightningScene.shared
        scene.size = UIScreen.screenSize
        scene.scaleMode = .fill
        scene.backgroundColor = .clear
        return scene
    }

    var body: some View {
        SpriteView(scene: rainLightningScene, options: [.allowsTransparency])
//            .frame(width: UIScreen.screenWidth,
//                   height: UIScreen.screenHeight)
            .ignoresSafeArea()
            .background(Color.clear)
    }
}


extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct Previews_RainEffect_Previews: PreviewProvider {
    static var previews: some View {
        RainEffect()
            .frame(width: 100, height: 100)
    }
}

