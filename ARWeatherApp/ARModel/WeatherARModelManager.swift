//
//  WeatherARModelManager.swift
//  ARWeatherApp
//
//  Created by mai abdullah qurun on 28/07/1444 AH.
//

import Foundation
import AVFoundation
import RealityKit
public class WeatherARModelManager {
    
    
    public func generateWeatherARModel (condition: String, temperature: Double) -> ModelEntity {
        
        // ball and text
        
        let conditionModel = weatherConditionModel(condition: condition)
        let temperatureText = createWeatherText(with: temperature)
        
        
        // place text on top of ball
        
        conditionModel.addChild(temperatureText)
        temperatureText.setPosition(SIMD3<Float>(x: -0.07, y: 0.05, z: 0), relativeTo: conditionModel)
        
        
        // name
        conditionModel.name = "weatherBall"
        return conditionModel
    }
    
        //Ball create ( condition )
        private func weatherConditionModel(condition:String) -> ModelEntity {
            
            // mesh
            let ballMesh = MeshResource.generateBox(size: 0.1)
            
            // video Material
            let videoItem = creatVideoItem(with: "cloud")
            let videoMaterial = createVideoMaterial(with: videoItem!)
            
            // Model Entity
            let ballModel = ModelEntity(mesh: ballMesh, materials: [videoMaterial])
            
            return ballModel
        }
        
        private func creatVideoItem(with fileName:String) -> AVPlayerItem? {
            
            // URL
            guard let url = Bundle.main.url(forResource: "cloud", withExtension: ".mp4") else {return nil}
            
            // video item
            let asset = AVURLAsset(url: url)
            let videoItem = AVPlayerItem(asset: asset)
            
            return videoItem
        }
        private func createVideoMaterial(with videoItem: AVPlayerItem) -> VideoMaterial {
            
            // video player
            let player = AVPlayer()
            
            // video material
            let videoMaterial = VideoMaterial(avPlayer: player)
            
            // play video
            player.replaceCurrentItem(with: videoItem)
            player.play()
            
            return videoMaterial
        }
        
        // text create (temperature)
        
        private func createWeatherText(with temperature: Double) -> ModelEntity {
            
            let mesh = MeshResource.generateText("\(temperature)°C", extrusionDepth: 0.1,  containerFrame: .zero, alignment: .left, lineBreakMode: .byTruncatingTail)
            let material = SimpleMaterial(color: .white, isMetallic: false)
            
            let textEntity = ModelEntity(mesh: mesh, materials: [material])
            textEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
            return textEntity
        }
    }

