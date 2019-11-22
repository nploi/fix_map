const utils = require('./utils')
const radiusInMeters = 1000.0; // 3km


let center = {
    latitude: 10.88278389,
    longitude: 106.60778046
}
  
  /**
   * Return 
[object Object] {
  northeast: [object Object] {
    lat: 10.88548183879291,
    lng: 106.61052785601188
  },
  southwest: [object Object] {
    lat: 10.880085916782168,
    lng: 106.60503311373262
  }
}
   */
console.log(utils.toBounds(center, radiusInMeters))
  
  