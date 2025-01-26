//
//  YearWidget.swift
//  widgetExtension
//
//  Created by xueping wang on 2025/1/25.
//


import WidgetKit
import SwiftUI

struct YearProvider: TimelineProvider {
    func placeholder(in context: Context) -> YearSimpleEntry {
        YearSimpleEntry(date: Date(),yearModel: YearModel(date: Date()), size: context.displaySize)
    }

    func getSnapshot(in context: Context, completion: @escaping (YearSimpleEntry) -> ()) {
        let entry = YearSimpleEntry(date: Date(),yearModel: YearModel(date: Date()), size: context.displaySize)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        let entry = YearSimpleEntry(date: Date(),yearModel: YearModel(date: Date()), size: context.displaySize)
        
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 24, to: Date())
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate!))
        
        completion(timeline)
        
       


      
    }

}

struct YearSimpleEntry: TimelineEntry {
    let date: Date
    let yearModel: YearModel
    let size: CGSize
}

struct YearWidgetEntryView : View {
    var entry: YearProvider.Entry

    var body: some View {
        HStack {
            
            YearItemView(size: CGSize(width: (entry.size.width - 40.0) / 4.0, height: entry.size.height - 10), progressModel: entry.yearModel.progessModels[0]).frame(width:(entry.size.width - 40.0) / 4.0,  height:   entry.size.height - 10)
            
            YearItemView(size: CGSize(width: (entry.size.width - 40.0) / 4.0, height: entry.size.height - 10), progressModel: entry.yearModel.progessModels[1]).frame(width:(entry.size.width - 40.0) / 4.0,  height:   entry.size.height - 10)
            
            YearItemView(size: CGSize(width: (entry.size.width - 40.0) / 4.0, height: entry.size.height - 10), progressModel: entry.yearModel.progessModels[2]).frame(width:(entry.size.width - 40.0) / 4.0,  height:   entry.size.height - 10)
            
            YearItemView(size: CGSize(width: (entry.size.width - 40.0) / 4.0, height: entry.size.height - 10), progressModel: entry.yearModel.progessModels[3]).frame(width:(entry.size.width - 40.0) / 4.0,  height:   entry.size.height - 10)
            
        }.frame(width: entry.size.width,height: entry.size.height).background(Color("ThemeColor"))
    }
}

struct YearWidget: Widget {
    let kind: String = "YearWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: YearProvider()) { entry in
            if #available(iOS 17.0, *) {
                YearWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                YearWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName(NSLocalizedString("year_widget_title", comment: ""))
        .description(NSLocalizedString("year_widget_des", comment: ""))
    }
}

