//
//  ContentView.swift
//  AzCommunicationService
//
//  Created by Mohsin Ali Ayub on 04.08.24.
//

import SwiftUI
import AzureCommunicationCalling
import AVFoundation

struct ContentView: View {
    @State var callee: String = ""
    @State var callClient: CallClient?
    @State var callAgent: CallAgent?
    @State var call: Call?
    @State var deviceManager: DeviceManager?
    @State var localVideoStream: [LocalVideoStream]?
    @State var incomingCall: IncomingCall?
    @State var sendingVideo: Bool = false
    @State var errorMessage: String = "Unknown"
    
    @State var remoteVideoStreamData:[Int32:RemoteVideoStreamData] = [:]
    @State var previewRenderer: VideoStreamRenderer? = nil
    @State var previewView: RendererView? = nil
    @State var remoteRenderer: VideoStreamRenderer? = nil
    @State var remoteViews: [RendererView] = []
    @State var remoteParticipant: RemoteParticipant?
    @State var remoteVideoSize: String = "Unknown"
    @State var isIncomingCall: Bool = false
    
    @State var callObserver: CallObserver?
    @State var remoteParticipantObserver: RemoteParticipantObserver?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
