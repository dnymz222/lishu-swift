//
//  ImageModel.swift
//  widgetExtension
//
//  Created by xueping wang on 2025/1/25.
//

import Foundation
import Combine
import UIKit

class ImageModel: ObservableObject {
    @Published var image: UIImage?
    @Published var error: NetworkError?
    var disposables = Set<AnyCancellable>()
//    var zpow: Double
//    var startY: Double
//    var endY: Double
    var date: Date
    
    public init() {
       
        self.date = Date()
    }

  
    func getCurrenDayNightImage(completion: ((ImageModel) -> Void)? = nil) {
        
        self.date = Date()
        
        let timestamp = Int(date.timeIntervalSince1970)
        guard  let url = URL.currentSun(time: timestamp) else {
            return
        }
  
        let minutePublisher = DataFetcher.fetchImage(url: url)
        let _ = minutePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completions in
                switch completions {
                case .finished:
                    break
                case .failure(let theError):
                  
                    DispatchQueue.main.async {
                        self.image = nil
                        
                        self.error = theError
                        
                        completion?(self)
                    }
                    break
                }
            }, receiveValue: { sun in
                
              
                DispatchQueue.main.async {
                    self.image = sun
                    completion?(self)
                }

            })
            .store(in: &disposables)
        
    
        
        
    }
    

    
    
    
    
}

enum NetworkError: Error, LocalizedError {
    case invalidHTTPResponse, invalidServerResponse, jsonParsingError, apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .invalidHTTPResponse:
            return "Invalid HTTP response"
        case .invalidServerResponse:
            return NSLocalizedString("aurora_forecast_tip", comment: "")
        case .jsonParsingError:
            return "Error parsing JSON"
        case .apiError(let reason):
            return reason
        }
    }
}

extension URL{
    static func currentSun(time: Int) -> URL? {
        return URL(string: String(format: "https://www.astronomyobserver.net/api/v3.0/lishu/daynight/%d", time))
    }
    
   
    
 
}



struct SunCoordinate {
    var x: Double
    var y: Double
}


struct SunModel: Decodable {
    
    let time: Int
    let jd: Double
    let delta_t: Double
    let es: Double
    let  ast: Double
    let sun_ra: Double
    let sun_dec: Double
    let sun_r: Double
    
    func zpow_v(_ z: Int)  -> Int {
        
        var a: Int = 1
        for _ in 0..<z{
            a = a * 2
        }
        return a
    }
    
    func tileToLongitude(_ x: Double, _ zpow: Double) -> Double {
       let lng = x / zpow * 360 - 180
       return lng;
   }
    
     func tileToLatitde(_ y: Double, _ zpow: Double) -> Double {
        let p: Double = zpow
       let q = 2 * Double.pi * y
       let n = Double.pi - q /  p
       let latitude = 180.0 / Double.pi * atan(0.5 * (exp(n) - exp(-n)))
       return latitude
   }
    
   func latitude_to_tile(_ latitude: Double, _ zpow: Double) -> Double{
        let  lat_rad = latitude / 180.0 * Double.pi
      
        let ytile = zpow * (1 - (log(tan(lat_rad) +  1/cos(lat_rad)) / Double.pi)) / 2
        
        return ytile
    }
    
    
    func  screenXtoLongitude(_ x: Int) -> Double {
        
        return  -180 + Double(x) / 720.0 * 360
    }
    
    func screenYtoLatitude(_ y: Int) -> Double {
        
        let zpow = Double(zpow_v(6))
        
        let startY = latitude_to_tile(70.81210731201662, zpow)
        let endY = latitude_to_tile(-55.74400303667873, zpow)
        
        let tile = startY  +  Double(y) / 338.0 * (endY - startY)
        
        return tileToLatitde(tile, zpow)

        
    }
    
    func generateImage() -> UIImage? {
        let width = 720
        let height = 338
    
        let rgbColors = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: width *  height * 4 * MemoryLayout<CUnsignedChar>.size)
        


        for i in 0..<height {
            for j in 0..<width {
                let longitude = self.screenXtoLongitude(j)
                let latitude = self.screenYtoLatitude(i)
                let h = calculateSun(latitude, longitude).y
                
                let n = i * width + j
                
                if (h > -0.8333) {
                   rgbColors[4 * n] = CUnsignedChar(0x00)
                   rgbColors[4 * n + 1] = CUnsignedChar(0x00)
                   rgbColors[4 * n + 2] = CUnsignedChar(0x00)
                   rgbColors[4 * n + 3] = CUnsignedChar(0x00)
               } else if( h > -6) {
                   rgbColors[4 * n] = CUnsignedChar(0x33)
                   rgbColors[4 * n + 1] = CUnsignedChar(0x33)
                   rgbColors[4 * n + 2] = CUnsignedChar(0x33)
                   rgbColors[4 * n + 3] = CUnsignedChar(0x66)
               }  else {
                   rgbColors[4 * n] = CUnsignedChar(0x33)
                   rgbColors[4 * n + 1] = CUnsignedChar(0x33)
                   rgbColors[4 * n + 2] = CUnsignedChar(0x33)
                   rgbColors[4 * n + 3] = CUnsignedChar(0x88)
               }
                
            }
        }
            

    
        
        let colorspace = CGColorSpaceCreateDeviceRGB();
     
        
        guard let data = CGContext(data: rgbColors, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 4 * width, space: colorspace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrderDefault.rawValue) else {
            return nil
        }
        
        guard let  cgImage = data.makeImage() else {
            return nil
        }
        
        let image =  UIImage(cgImage: cgImage)
        free(rgbColors)
        return image
      
    }
    
    
    
    func calculateSun(_ latitude: Double, _ longitude: Double) -> SunCoordinate{
        
        let JDSun = self.jd + self.delta_t / 86400.0
        let SunRad = self.sun_r

       let  Longitude = -longitude; //West is considered positive
       let Latitude = latitude;
        let Height = 1706.0;
        let SunTopo = Equatorial2Topocentric(self.sun_ra, self.sun_dec, SunRad, Longitude, Latitude, Height, JDSun);
   
   
        let AST = self.ast
       let LongtitudeAsHourAngle = DegreesToHours(Longitude)
        let  LocalHourAngle = AST - LongtitudeAsHourAngle - SunTopo.x;
        
        let coordinate =   Equatorial2Horizontal(LocalHourAngle, SunTopo.y, Latitude)
        
        return coordinate
    }
    
    func RhoSinThetaPrime(_ GeographicalLatitude: Double,  _ Height: Double) -> Double
    {
      //Convert from degress to radians
        let  GeographicalLatitude_r = DegreesToRadians(GeographicalLatitude)

        let  U = atan(0.99664719 * tan(GeographicalLatitude_r))
        return 0.99664719 * sin(U) + (Height/6378140 * sin(GeographicalLatitude_r));
    }

    func RhoCosThetaPrime(_ GeographicalLatitude: Double,  _ Height: Double) -> Double
    {
      //Convert from degress to radians
        let  GeographicalLatitude_r = DegreesToRadians(GeographicalLatitude)

        let U = atan(0.99664719 * tan(GeographicalLatitude_r));
        return cos(U) + (Height/6378140 * cos(GeographicalLatitude_r));
    }
    
    
    func DegreesToRadians(_ degree: Double) -> Double {
        return  degree * 0.017453292519943295769236907684886
    }
    
    func RadiansToDegrees(_ Radians: Double) -> Double
    {
      return Radians * 57.295779513082320876798154814105;
    }
    
    
    func HoursToRadians(_ Hours: Double) -> Double
    {
      return Hours * 0.26179938779914943653855361527329;
    }
    
    func DegreesToHours(_ degree: Double) -> Double {
        return degree / 15.0;
    }
    
    func RadiansToHours(_ Radians: Double) -> Double
    {
        return Radians * 3.8197186342054880584532103209403;
    }
    
    func MapToRange(_ value: Double,_ range: Double) -> Double {
        var an = value.truncatingRemainder(dividingBy: range)
        if an < 0.0 {
            an += range
        }
        return an
    }
    
    



    
    
    func Equatorial2Topocentric(_  Alpha: Double, _ Delta: Double,  _ Distance: Double, _ Longitude: Double,  _ Latitude: Double,  _ Height: Double, _ JD: Double) -> SunCoordinate
    {
      let RhoSinThetaPrime = RhoSinThetaPrime(Latitude, Height);
      let RhoCosThetaPrime = RhoCosThetaPrime(Latitude, Height);

      //Calculate the Sidereal time
        let theta = self.ast ;

      //Convert to radians
     let Delta_r = DegreesToRadians(Delta);
        let  cosDelta = cos(Delta_r);

      //Calculate the Parallax
      let pi = asin(4.2634515103856459e-05 / Distance);
      let sinpi = sin(pi)
        

      //Calculate the hour angle
        let H = HoursToRadians(theta - Longitude/15.0 - Alpha)
      let  cosH = cos(H)
      let  sinH = sin(H)

      //Calculate the adjustment in right ascension
      let DeltaAlpha = atan2(-RhoCosThetaPrime*sinpi*sinH, cosDelta - RhoCosThetaPrime*sinpi*cosH);

   
        let X = MapToRange(Alpha + RadiansToHours(DeltaAlpha),24.0);
        let Y = RadiansToDegrees(atan2((sin(Delta_r) - RhoSinThetaPrime*sinpi) * cos(DeltaAlpha), cosDelta - RhoCosThetaPrime*sinpi*cosH));

        return SunCoordinate(x: X,y: Y);
    }
    
    
    func Equatorial2Horizontal(_ LocalHourAngle: Double, _ Delta: Double,  _ Latitude: Double) -> SunCoordinate
    {
     let  LocalHourAngle = HoursToRadians(LocalHourAngle)
     let  Delta = DegreesToRadians(Delta)
      let Latitude = DegreesToRadians(Latitude)


      var x = RadiansToDegrees(atan2(sin(LocalHourAngle), cos(LocalHourAngle)*sin(Latitude) - tan(Delta)*cos(Latitude)));
        if (x < 0) {
            x += 360;
        }
      var  y = RadiansToDegrees(asin(sin(Latitude)*sin(Delta) + cos(Latitude)*cos(Delta)*cos(LocalHourAngle)));
        
        y = y + RefractionFromTrue(y, 1013, 10)

        return SunCoordinate(x: x,y: y)
    }
    
    
    func RefractionFromTrue(_ Altitude_v: Double, _ Pressure: Double, _ Temperature: Double) -> Double
    {
        var Altitude = Altitude_v;
      //return a constant value from this method if the altitude is below a specific value
        if (Altitude <= -1.9006387000003735) {
            Altitude = -1.9006387000003735
        }

      var value = 1.02 / (tan(DegreesToRadians(Altitude + 10.3/(Altitude + 5.11)))) + 0.0019279;
      value *= (Pressure/1010 * 283/(273+Temperature));
      value /= 60;
      return value
    }

}

struct SunDataModel: Decodable {
    let code: Int
    let data: SunModel
}


struct DataFetcher {
    
    

    static func fetchImage(url: URL?) -> AnyPublisher<UIImage?, NetworkError> {
        guard let url = url else {
            fatalError("Url error?")
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> UIImage? in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidHTTPResponse
                }
                //print(String(bytes: data, encoding: String.Encoding.utf8))
                let value = try JSONDecoder().decode(SunDataModel.self, from: data)
                let image = value.data.generateImage()
                
                return image
        }
        .mapError { error in
            if let _ = error as? DecodingError {
                return NetworkError.jsonParsingError
            } else if let error = error as? NetworkError {
                return error
            }

            // handle service errors (e.g. not being able to connect)
            return NetworkError.invalidServerResponse
        }
        .eraseToAnyPublisher()
    }
    
    

}
