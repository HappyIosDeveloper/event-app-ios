//
//  SessionHeaderView.swift
//  TEDxConnect
//
//  Created by Tadeh Alexani on 9/4/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct SessionHeaderView: View {
    
    let session: Day.Session
    
    var body: some View {
        HStack(spacing: 10) {
            Spacer()
            Text(DateHelper.ommitSeconds(fromTime: session.startTime))
                .customFont(name: Fonts.shabnam, style: .subheadline, weight: .regular)
                .foregroundColor(Colors.primaryRed)
            
            Text(session.title)
                .customFont(name: Fonts.shabnam, style: .subheadline, weight: .regular)
        }
    }
}

struct SessionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SessionHeaderView(session: Day.Session.example)
    }
}