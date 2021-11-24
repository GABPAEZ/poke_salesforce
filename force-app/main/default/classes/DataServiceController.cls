public with sharing class DataServiceController {

    @AuraEnabled(cacheable = true)
    public static Map <String, Object> getData(){
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('https://pokeapi.co/api/v2/pokemon/');
        httpRequest.setMethod('GET');

        Map<String, Object> pokerJsonData = new Map<String, Object>();
        String strResponse = null;

        try {
            Http http = new Http();
            HttpResponse httpResponse = http.send(httpRequest);
            if(httpResponse.getStatusCode() == 200){
                strResponse = httpResponse.getBody();
            } else {
                throw new CalloutException(httpResponse.getBody());
            }
        } catch (Exception e){
            throw e;
        }

        if(!String.isBlank(strResponse)){
           pokerJsonData = (Map<String, Object>) JSON.deserializeUntyped(strResponse);
        }
        if(!pokerJsonData.isEmpty()){
            return pokerJsonData;
        } else {
            throw new CalloutException('No data found');
        }
    }
}
