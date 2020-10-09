//
//  TalkCell.swift
//  TEDxConnect
//
//  Created by Tadeh Alexani on 9/10/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct TalkCell: View {
  
  let talk: Talk
  let cellWidth: CGFloat = 120
  
  var body: some View {
    NavigationLink(destination: TalkDetailView(id: talk.id)) {
      VStack {
        
        KFImage(URL(string: Images.urlExtension + talk.section.image)!)
          .placeholder {
            ImagePlaceholder()
          }
          .resizable()
          .scaledToFill()
          .frame(width: self.cellWidth, height: self.cellWidth)
          .cornerRadius(10)
        
        VStack(alignment: .leading) {
          Text(talk.title)
            .customFont(name: Fonts.shabnam, style: .headline)
            .lineLimit(2)
          Text(talk.speakers.map { $0.title }.joined(separator: ", "))
            .customFont(name: Fonts.shabnam, style: .subheadline)
            .foregroundColor(.secondary)
        }
      }
      .frame(width: self.cellWidth)
    }
    .buttonStyle(PlainButtonStyle())
    
  }
}

struct TalkCell_Previews: PreviewProvider {
  static var previews: some View {
    TalkCell(talk: Talk.example)
  }
}