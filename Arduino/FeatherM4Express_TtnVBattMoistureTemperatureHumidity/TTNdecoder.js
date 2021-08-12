function Decoder(bytes, port) {
 var decoded = {};

 if (port === 1){
  
  decoded.battery = ((bytes[0]<<8)+bytes[1])/100;

  decoded.moisture = (bytes[2]<<8)+bytes[3];
  decoded.temperature = ((bytes[4]<<8)+bytes[5])/100;
  decoded.humidity= ((bytes[6]<<8)+bytes[7])/100;
 }

  return decoded;

}
