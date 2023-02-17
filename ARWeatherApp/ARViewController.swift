//
//  ARViewController.swift
//  ARWeatherApp
//
//  Created by Noura Mohammad Althrowi on 24/07/1444 AH.
//

import Foundation
import RealityKit
import ARKit

final class ARViewController: ObservableObject{
    static var shared = ARViewController()
    private var weatherModelAnchor: AnchorEntity?
    
    @Published var arView: ARView
    init (){
        arView = ARView(frame:.zero)
    }
    public func startARSession(){
        startPlaneDetection()
        startTapDetection()
    }
    
    
    //setup
    private func startPlaneDetection(){
        arView.automaticallyConfigureSession = true
        
        //configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        
        //start plane detection
        arView.session.run(configuration)
    }
    
    private func startTapDetection(){
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(handleTap(recognizer:))))
    }
        @objc
        private func handleTap(recognizer:UITapGestureRecognizer) {
            //touch location
            let taplocation = recognizer.location(in: arView)
            
            //raycast 2D -> 3D
            let results = arView.raycast(from: taplocation, allowing: .estimatedPlane, alignment: .horizontal)
            
            //if plane detected
            if let firstResult = results.first{
                // 3D pos x,y,z
                let worldPosition = simd_make_float3(firstResult.worldTransform.columns.3)
                
              //  if(isWeatherObjectPlaced == false){
                    
                    //Mark: create model
                 //   let eatherBall = weatherModelGenerator.generateWeatherARModel(condition:
                     //   recievedWeatherData.conditionName,temperature:recievedWeatherData.temperature)
                    //Mark: place
                   // placeObject(object: weatherBall, at: worldPosition)
                    //isWeatherObjectPlaced=true
                
                //create 3D model
                let mesh = MeshResource.generateSphere(radius: 0.03)
                let material = SimpleMaterial(color: .black, isMetallic: true)
                let model = ModelEntity(mesh: mesh, materials:[material])
                //place object
                placeObject(object: model, at: worldPosition)
            }
        }
        //place object
        private func placeObject(object modelEntity: ModelEntity, at position: SIMD3<Float>){
            //anchor
            weatherModelAnchor = AnchorEntity(world: position)
            //tie model to anchor
            weatherModelAnchor!.addChild(modelEntity)
            //add anchor to scene
            arView.scene.addAnchor(weatherModelAnchor!)
        }
    
    
    
    
    
    
    
    
    
            }
            //place objetc

        
 
