//
//  SwiftUIView.swift
//  ios_app
//
//  Created by 楊詠崴 on 2022/12/14.
//

import SwiftUI

struct BoxView: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.index)]) var obj: FetchedResults<Box>
    var body: some View {
        VStack{
            ForEach(obj){ obj in
                SingleBox(obj: obj)
            }
        }
    }
}

struct BoxView_Previews: PreviewProvider {
    static var previews: some View {
        BoxView()
    }
}
