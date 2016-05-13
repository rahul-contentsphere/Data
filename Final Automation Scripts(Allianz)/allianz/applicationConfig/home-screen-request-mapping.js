
var assetServerURL = 'http://192.168.132.96:8085/';

exports.homeScreenRequestMapping = {
  'GetTag': 'config/tags',
  'GetKlass': 'config/classes',
  'GetAttributes': 'config/attributes',
  'GetContentType': 'content/type/get',
  'GetContentStatus': 'content/status/get',
  'GetClass': 'config/classes/<%=id%>',
  'Logout': 'logout',
  'GetCurrentUser':'config/currentUser',
  'AuthenticateAsset': assetServerURL + 'authenticate/'
};

exports.assetServerURL =  assetServerURL;

