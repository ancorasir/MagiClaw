//
//  RoboticDataCollectionApp.swift
//  RoboticDataCollection
//
//  Created by 吴天禹 on 2024/7/27.
//

import SwiftUI
import SwiftData

@main
struct MagiClawApp: App {
    @State private var recordAllDataModel = RecordAllDataModel()
    @State var webSocketManager = WebSocketManager.shared
//    @StateObject var tcpServerManager = TCPServerManager(port: 8080)
    @StateObject var websocketServer = WebSocketServerManager(port: 8080)
    @Environment(\.scenePhase) private var scenePhase // 用于监控应用的生命周期阶段
    @AppStorage("hostname") private var hostname = "raspberrypi.local"
    @AppStorage("firstLaunch") private var isFirstLaunch = true
    
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(recordAllDataModel)
                .environment(webSocketManager)
                .environmentObject(ARRecorder.shared)
//                .environmentObject(tcpServerManager)
                .environmentObject(websocketServer)
                .modelContainer(for: AllStorgeData.self)
//                .modelContainer(container)
        }
       
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background, .inactive:
                // 应用进入后台或变为非活动状态时
                webSocketManager.disconnect()
                print("WebSocket disconnected.")
            case .active:
                // 应用回到前台时
                webSocketManager.reConnectToServer()
                print("WebSocket reconnected.")
            default:
                break
            }
        }
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

