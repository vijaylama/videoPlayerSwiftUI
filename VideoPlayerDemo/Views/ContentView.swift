//
//  ContentView.swift
//  VideoPlayerDemo
//
//  Created by Vijay Lama on 3/29/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var videoManager = VideoManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    ForEach(Query.allCases, id: \.self){ searchQuery in
                        QueryTag(query: searchQuery, isSelected: videoManager.selectedQuery == searchQuery)
                            .onTapGesture {
                                videoManager.selectedQuery = searchQuery
                            }
                        
                    }
                }//: HStack
                ScrollView {
                    if videoManager.videos.isEmpty{
                        ProgressView()
                    }
                    LazyVGrid(columns: columns, spacing: 20){
                        ForEach(videoManager.videos, id: \.id) { video in
                            NavigationLink {
                                VideoView(video: video)
                            } label: {
                                VideoCard(video: video)
                            }
                        }
                    }//: LazyVGrid
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color("AccentColor"))
            .navigationBarHidden(true)
        }//: NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
