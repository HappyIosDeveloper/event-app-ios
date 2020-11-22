//
//  HomeTabUIView.swift
//  TEDxConnect
//
//  Created by Farshid on 11/5/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI


enum MainViewType {
    case home
    case speakers
    case timeDay
}

struct HomeTabUIView: View {
    
    @State var mainViewType: MainViewType = .home
    
    var  eventViewModel : EventViewModel
    var dayViewModel : DayViewModel
    var speakerViewModel:SpeakerViewModel
    
    var body: some View {
        VStack {
            Picker("", selection: self.$mainViewType) {
                Text("Home".localized())
                    .tag(MainViewType.home)
                Text("Speakers".localized())
                    .tag(MainViewType.speakers)
                Text("TimeDay".localized())
                    .tag(MainViewType.timeDay)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.top,.horizontal])
            
            if self.mainViewType == .home {
                EventDetailView()
                    .environmentObject(self.eventViewModel)
            }else if self.mainViewType == .speakers {
                SpeakersView(viewModel: self.speakerViewModel)
            }else {
                TimeTableView()
                    .environmentObject(self.dayViewModel)
            }
            
            Spacer()
        }.background(Colors.primaryLightGray)
    }
    
}

struct HomeTabUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabUIView(eventViewModel: EventViewModel(), dayViewModel: DayViewModel(),speakerViewModel:SpeakerViewModel())
    }
}
