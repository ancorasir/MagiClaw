//
//  SettingView.swift
//  talkWithRpi
//
//  Created by Tianyu on 7/22/24.
//

import SwiftUI
import MessageUI

struct SettingView: View {
    @AppStorage("ignore websocket") private var ignorWebsocket = false
    @EnvironmentObject  var arRecorder: ARRecorder
    @Environment(WebSocketManager.self) private var webSocketManager
    @AppStorage("hostname") private var hostname = "raspberrypi.local"
    @AppStorage("selectedFrameRate") var selectedFrameRate: Int = 30
    
    let availableFrameRates = [30, 60] // 可以选择的帧率选项
    
    @State private var showMailComposer = false
    @State private var showMailErrorAlert = false
    @State private var isShowingMailView = false
    @State private var showInfo = false
   
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("General")) {
                    Toggle(isOn: $ignorWebsocket) {
                        Text("Ignore Raspberry Pi connection")
                    }
                    
                    HStack {
                        Text("Frame Rate")
                        Spacer()
                        Picker("Frame Rate", selection: $selectedFrameRate) {
                            ForEach(availableFrameRates, id: \.self) { rate in
                                Text("\(rate) FPS").tag(rate)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    HStack {
                        Text("Hostname")
                        TextField("Enter hostname", text: $hostname)
                            .keyboardType(.URL) // 设置键盘类型为URL
                            .textContentType(.URL)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(5)
                            .onChange(of: hostname) { oldValue, newValue in
                                // 防止hostname被设置为空
                                guard !newValue.isEmpty else { return }
                                webSocketManager.setHostname(hostname: newValue)
                                webSocketManager.reConnectToServer()
                            }
                    }
                    
                    NavigationLink(destination: NewScenarioView()) {
                        Text("Scenario")
                    }
                }
                Section(header: Text("Device info")) {
                    HStack {
                        Text("iPhone's IP Address")
                        Spacer()
                        IPView()
                        
                    }
                    
                }
                Section() {
                    Button(action: {
                        self.showInfo.toggle()
                    }, label: {
                        Label("About", systemImage: "info.circle")
                            .foregroundColor(.blue)
                            
                    })
//                    HStack {
//                        
//                        
//                            
//                        Spacer()
//                    }
//                    .contentShape(Rectangle()) // 扩展点击区域
//                    .onTapGesture {
//                        self.showInfo.toggle()
//                    }
                }
                
            }
            
            .navigationTitle("Settings")
            .sheet(isPresented: self.$showInfo) {
                InfoView(isShowingMailView: self.$isShowingMailView)
            }
        }
    }
}



#Preview {
    SettingView()
        .environmentObject(ARRecorder.shared)
        .environment(WebSocketManager.shared)
    
}

