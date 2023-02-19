//
//  ContentView.swift
//  ARWeatherApp
//
//  Created by Noura Mohammad Althrowi on 23/07/1444 AH.
//

import SwiftUI
import ARKit
import RealityKit

struct ContentView: View {
    @State var cityName: String = "London"
    @State var isSearchBarVisible: Bool = true
    //Debug
    @State var temp:Double = 0
    @State var condition: String = ""
    
    @ObservedObject var weatherManager = WeatherNetworkManager()
    
    var body: some View {
        ZStack{
            //AR View
            ARViewDisplay()
            //UI controls
            VStack{
                if (isSearchBarVisible){
                    //search bar
                    searchBar(cityName: $cityName)
                        .transition(.scale)
                }
                Spacer()
                
                
                //search toggle
                SearchToggle(isSearchToggle: $isSearchBarVisible)
            }
            .onChange(of: cityName, perform: { value in
                weatherManager.fetchData(cityName: cityName)
            })
            .onReceive(weatherManager.$recievedWeatherData, perform: {
                (recievedData) in
                temp = recievedData?.temperature ?? 0
                condition = recievedData?.conditionName ?? "Nothing here"
            })
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// mark: search stuff
struct searchBar: View{
    @State var searchText:String = ""
    @Binding var cityName:String
    
    var body: some View {
        HStack{
            //search icon
            Image(systemName: "magnifyingglass")
                .font(.system(size:30))

            //search text
            TextField("Search", text:$searchText) { (value) in
                print("typing in progress")
            } onCommit: {
                cityName = searchText
            }
        }.frame(maxWidth:500)
            .padding(.all)
            .background(Color.black.opacity(0.25))
    }
}

struct SearchToggle: View{
    @Binding var isSearchToggle: Bool
    var body: some View {
        Button(action: {
            withAnimation{
                isSearchToggle = !isSearchToggle
            }
            //toggle search bar
            isSearchToggle = !isSearchToggle
        },label:{
            Image(systemName: "magnifyingglass")
                .font(.system(size:40))
                .foregroundColor(Color.black)
            
        })
        
    }
}
//AR View
struct ARViewDisplay: View{
    var body: some View{
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}
struct ARViewContainer: UIViewRepresentable {
    
    typealias UIViewType = ARView
    
    func makeUIView(context: Context) -> ARView {
        ARViewController.shared.startARSession()
        return ARViewController.shared.arView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
