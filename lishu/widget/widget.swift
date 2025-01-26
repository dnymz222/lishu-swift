//
//  widget.swift
//  widget
//
//  Created by xueping wang on 2025/1/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    let imageModel = ImageModel()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),size: context.displaySize,imageModel: imageModel)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),size: context.displaySize,imageModel: imageModel)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        imageModel.getCurrenDayNightImage() { imageM in
            // testing to see how often this gets hit. remove before release.
            

            let entry = SimpleEntry(date: Date(), size: context.displaySize,imageModel: imageM)
            // make sure that we get refreshed
            // to be really usefull to the user it would be better to do this more like
            // every 15 minutes. But, that would be more api calls per day than we get
            let refreshDate = Calendar.current.date(byAdding: .minute, value: 24, to: Date())
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate!))
            completion(timeline)
        }
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let size: CGSize
    let imageModel: ImageModel
}

struct widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image("World-map-time-zones").resizable().frame(width: entry.size.width,height: entry.size.height,alignment: .center)
            
            if let image = entry.imageModel.image {
                Image(uiImage: image).resizable().frame(width: entry.size.width,height: entry.size.height,alignment: .center)
                

            }  else if let error = entry.imageModel.error {
                Text(error.errorDescription ?? "")
            } else {
                Text("nothing")
            }
            
            
        }.frame(width: entry.size.width,height: entry.size.height).background(Color("ThemeColor"))
    }
}

struct widget: Widget {
    let kind: String = "dayandnightwigdet"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                widgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                widgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .supportedFamilies([.systemMedium,.systemExtraLarge])
        .configurationDisplayName(NSLocalizedString("day_night_title", comment: ""))
        .description(NSLocalizedString("day_night_des", comment: ""))
    }
}

