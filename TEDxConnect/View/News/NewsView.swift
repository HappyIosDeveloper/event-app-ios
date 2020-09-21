//
//  NewsView.swift
//  TEDxConnect
//
//  Created by Tadeh Alexani on 8/28/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct NewsView: View {
  
  @EnvironmentObject var viewModel: NewsViewModel
  
  var body: some View {
    ZStack {
      if self.viewModel.statusView == .complete {
        if viewModel.repositories.count != 0 {
          List(viewModel.repositories, id: \.self) { news in
            NewsCardView(news: news)
          }
          .listSeparatorStyle(.none)
        } else {
          EmptyListView()
            .onTapGesture {
              self.viewModel.setup()
            }
        }
      }
      
      if self.viewModel.statusView == .loading {
        Indicator()
      }
      
      if self.viewModel.statusView == .error {
        Text(self.viewModel.errorMessage)
          .customFont(name: Fonts.shabnam, style: .caption1, weight: .medium)
      }
      
    }
    .navigationBarColor(UIColor(named: "primaryRed"))
    .navigationBarTitle(Text("News"), displayMode: .inline)
  }
  
}

struct NewsView_Previews: PreviewProvider {
  static var previews: some View {
    NewsView().environmentObject(NewsViewModel())
  }
}
