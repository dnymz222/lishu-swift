//
//  YearItemView.swift
//  widgetExtension
//
//  Created by xueping wang on 2025/1/25.
//

import SwiftUI

struct YearItemView: View {
    var size: CGSize
    var progressModel: CalendarProgessModel
    var body: some View {
        VStack {
            ProgessView(progressModel: progressModel).frame(width: size.width,height: size.width)
            Text(progressModel.progess).foregroundColor(Color("TextNormalColor")).font(Font.system(size: 15,weight: .regular))
            Text(progressModel.name).foregroundColor(Color("TextFadeColor")).font(Font.system(size: 13,weight: .light))
        }
    }
}


struct ProgessView: View {
    var progressModel: CalendarProgessModel
    var body: some View {
        ZStack {
            ProgessPathView(endAngle: Angle(radians: Double.pi * 1.5)).stroke(Color("TextFadeColor"),lineWidth: 6)
            ProgessPathView(endAngle: progressModel.endAngle).stroke(Color("ProgessColor"),lineWidth: 6)
            Text(progressModel.percent).foregroundColor(Color("TextDarkColor")).font(Font.system(size: 16,weight: .medium))
        }
    }
    
}

struct ProgessPathView: Shape {
    var endAngle: Angle
    func path(in rect: CGRect) -> Path {
        
           var path = Path()
           path.addArc(center: rect.centerpoint(), radius: rect.radius(), startAngle: Angle(radians: -Double.pi/2), endAngle: endAngle, clockwise: false)

           return path
       }
    
}


extension CGRect {
    func centerpoint() -> CGPoint {
        let width = self.size.width
        let height = self.size.height
        return CGPoint(x:self.minX + width / 2 , y: self.minY + height / 2)
    }
    
    func radius() -> CGFloat {
        return self.size.width / 2 - 8;
    }
}

