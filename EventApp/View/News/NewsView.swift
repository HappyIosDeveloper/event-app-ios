//
//  NewsView.swift
//  TEDxConnect
//
//  Created by Tadeh Alexani on 8/28/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct NewsView: View {
  
  var viewModel: NewsViewModel
  
  var body: some View {
    NavigationView {
      ZStack {
        if self.viewModel.statusView == .complete {
          if viewModel.repositories.count != 0 {
            ScrollView(.vertical) {
              ForEach(viewModel.repositories, id: \.self) { news in
                NewsCardView(news: news)
              }
              .padding()
            }
            .environment(\.layoutDirection, Configuration.direction)
            
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
          ErrorView(errorText: self.viewModel.errorMessage)
            .onTapGesture {
              self.viewModel.setup()
            }
        }
        
      }
      .navigationBarTitle(Text("News".localized()), displayMode: .inline)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
  
}

struct NewsView_Previews: PreviewProvider {
  static var previews: some View {
    NewsView(viewModel: NewsViewModel())
  }
}
