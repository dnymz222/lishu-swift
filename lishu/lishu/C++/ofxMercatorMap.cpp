#include "ofxMercatorMap.h"



//--------------------------------------------------------------
ofxMercatorMap::ofxMercatorMap()  {}
ofxMercatorMap::~ofxMercatorMap() {}
    
//--------------------------------------------------------------
void ofxMercatorMap::setup(float _mapScreenWidth, float _mapScreenHeight, float _leftLongitude, float _bottomLatitude, float _rightLongitude, float _topLatitude) {
        
    mapScreenWidth  = _mapScreenWidth;
    mapScreenHeight = _mapScreenHeight;
    topLatitude     = _topLatitude;
    bottomLatitude  = _bottomLatitude;
    leftLongitude   = _leftLongitude;
    rightLongitude  = _rightLongitude;
    
    
    topLatitudeRelative     = getScreenYRelative(topLatitude);
    bottomLatitudeRelative  = getScreenYRelative(bottomLatitude);
    
    leftLongitudeRadians    =   CAACoordinateTransformation::DegreesToRadians(leftLongitude);
    rightLongitudeRadians   = CAACoordinateTransformation::DegreesToRadians(rightLongitude);
    
}

//--------------------------------------------------------------
float ofxMercatorMap::getScreenYRelative(float latitudeInDegrees) {
    return log(tan(latitudeInDegrees / 360 * M_PI + M_PI / 4));
}


float ofxMercatorMap::getLatitudeInDegrees(float YRelative) {
    double ey = exp(YRelative) ;
    double tanx  = (ey-1)/(ey+1);
    double x= atan(tanx)*2;
    
    return CAACoordinateTransformation::RadiansToDegrees(x);
}




//--------------------------------------------------------------
float ofxMercatorMap::getScreenX(float longitudeInDegrees) {
    float longitudeInRadians = CAACoordinateTransformation::DegreesToRadians(longitudeInDegrees);
    return mapScreenWidth * (longitudeInRadians - leftLongitudeRadians) / (rightLongitudeRadians - leftLongitudeRadians);
}

//--------------------------------------------------------------
float ofxMercatorMap::getScreenY(float latitudeInDegrees) {
    return mapScreenHeight * (getScreenYRelative(latitudeInDegrees) - topLatitudeRelative) / (bottomLatitudeRelative - topLatitudeRelative);
}

//--------------------------------------------------------------
CAA2DCoordinate  ofxMercatorMap::getScreenLocationFromLatLon(float lat, float lon) {
    float latitudeInDegrees  = lat;
    float longitudeInDegrees = lon;
    CAA2DCoordinate Galactic;
    Galactic.X = getScreenX(longitudeInDegrees);
    Galactic.Y = getScreenY(latitudeInDegrees);
    return Galactic;
}

CAA2DCoordinate  ofxMercatorMap::getLatLonFromScreenLocation(float x, float y) {
    
    
    double longtitude =  leftLongitude + x/mapScreenWidth *(rightLongitude-leftLongitude);
    
    double latituderelative  = topLatitudeRelative + y/mapScreenHeight*(bottomLatitudeRelative-topLatitudeRelative);
    
    CAA2DCoordinate Galactic;
    Galactic.X = longtitude;
    Galactic.Y = getLatitudeInDegrees(latituderelative);
    return Galactic;
}





