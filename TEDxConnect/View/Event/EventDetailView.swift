//
//  EventDetailView.swift
//  TEDxConnect
//
//  Created by Tadeh Alexani on 8/31/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage
import Sentry

struct EventDetailView: View {
    
    @EnvironmentObject var viewModel: EventViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if self.viewModel.statusView == .error {
                    ErrorView(errorText: self.viewModel.errorMessage)
                        .onTapGesture {
                            self.viewModel.setup()
                        }
                }else {
                    self.mainContent
                }
            }
            
            
        } // ScrollView
        .background(Colors.primaryLightGray)
       
        
    } // Body
    
    private var mainContent : some View {
        VStack {
            KFImage(URL(string: Images.urlExtension + (self.viewModel.event.banner ?? ""))!)
                .placeholder {
                    ImagePlaceholder()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
                .frame(height: 200)
                .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity)
                .padding()
            
            if !self.viewModel.event.liveUrl.isEmpty {
                Button(action: {
                    if let url = URL(string: viewModel.event.liveUrl) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }) {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "play.rectangle")
                        Text(LocalizedStringKey("Watch Live"))
                            .customFont(name: Fonts.shabnam, style: .body, weight: .bold)
                        Spacer()
                    }
                    .padding(.vertical)
                }
                .customStyle(withBackgroundColor: Colors.primaryRed)
            }
            
            
            
            VStack(alignment: .leading) {
                if !self.viewModel.event.ticketUrl.isEmpty {
                    Button {
                        if let url = URL(string: self.viewModel.event.ticketUrl) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    } label: {
                        HStack {
                            Image(decorative: "ticket-icon")
                            Text(LocalizedStringKey("Buy Ticket"))
                                .customFont(name: Fonts.shabnam, style: .footnote, weight: .regular)
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal)
                    .foregroundColor(Colors.primaryRed)
                    Divider()
                }
                if !self.viewModel.event.registerationUrl.isEmpty {
                    Button {
                        if let urlMap = URL(string: self.viewModel.event.registerationUrl) {
                            UIApplication.shared.open(urlMap, options: [:], completionHandler: nil)
                        }
                    } label: {
                        HStack {
                            Image(decorative: "register-icon")
                            Text(LocalizedStringKey("Register in Event"))
                                .customFont(name: Fonts.shabnam, style: .footnote, weight: .regular)
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal)
                    .foregroundColor(Colors.primaryRed)
                    Divider()
                }
                
                HStack {
                    Image(decorative: "clock-icon")
                    Text(DateHelper.dateWith(self.viewModel.event.startDate ?? "TBA", showTime: true))
                        .customFont(name: Fonts.shabnam, style: .footnote, weight: .regular)
                    Text(DateHelper.dateWith(self.viewModel.event.endDate  ?? "TBA", showTime: true))
                        .customFont(name: Fonts.shabnam, style: .footnote, weight: .regular)
                }
                .padding()
                Divider()
                HStack {
                    Image(decorative: "venue-icon")
                    Text(self.viewModel.event.venue?.title ?? "-")
                        .customFont(name: Fonts.shabnam, style: .footnote, weight: .regular)
                }
                .padding()
                Divider()
                HStack {
                    Image(decorative: "address-icon")
                    Text(self.viewModel.event.venue?.address ?? "-")
                        .customFont(name: Fonts.shabnam, style: .footnote, weight: .regular)
                }
                .padding()
            }
            .background(Colors.primaryBackground)
            .cornerRadius(10)
            .foregroundColor(.secondary)
            .padding([.vertical, .bottom])
            
            if !(self.viewModel.event.venue?.mapImage ?? "").isEmpty {
                KFImage(URL(string: Images.urlExtension + (self.viewModel.event.venue?.mapImage ?? ""))!)
                    .placeholder {
                        ImagePlaceholder()
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .onTapGesture {
                        if let url = URL(string: viewModel.event.venue?.mapLink ?? Constants.placeholderUrl) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                        
                    }
                    .padding(.bottom)
            }
            
            
            
            if TimeZone.current.isMasterData {
                NavigationLink(destination: SponsorsView(eventId: viewModel.event.id)) {
                    HStack {
                        Spacer()
                        Text(LocalizedStringKey("Sponsors"))
                            .customFont(name: Fonts.shabnam, style: .body, weight: .bold)
                        Spacer()
                    }
                    .padding()
                    .customStyle(withBackgroundColor: Colors.primaryRed)
                }
            }
            
        } // VStack
        .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity)
        .padding(.horizontal)
    }
    
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView().environmentObject(EventViewModel())
    }
}
