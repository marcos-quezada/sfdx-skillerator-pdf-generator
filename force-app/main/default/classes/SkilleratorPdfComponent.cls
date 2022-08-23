public class SkilleratorPdfComponent {
    @AuraEnabled
    public static String doCallout(Id accountId){
        if(accountId == null){
            throw new MyException('Missing record id');
        }

        String endpointBase = 'http://159.223.24.62/project/';
        endpointBase += accountId;
        String endpointCompile = endpointBase + '/compile';
        String thisIsAtest = 'Hallo';

        List<Account> accounts = [SELECT toLabel(CountryOfOriginPick__c),Description,FirstName,Gender__pc,LastName,MiddleName,PersonBirthdate,Salutation,PersonMailingStreet,PersonMailingPostalCode,PersonMailingCity FROM Account WHERE Id = :accountId];
        if(accounts.isEmpty()){
            throw new MyException('Could not find the account');
        }
        
        Account account = accounts[0];
        
        String genderStr = account.Salutation;

        String body = '{' +
            '"compile": {' +
                '"options": {' +
                    '"compiler": "xelatex",' +
                    '"timeout": 40' + 
                '},' +
                '"resources": [{' +
                    '"path": "s1_Erklaerung_zum_Beschaeftigungsverhaeltnis-000001.png",' +
                    '"url": "http://resources-server/images/Erklaerung_zum_Beschaeftigungsverhaeltnis-000001.png"' +
                '},{' +
                    '"path": "s2_Erklaerung_zum_Beschaeftigungsverhaeltnis-000002.png",' +
                    '"url": "http://resources-server/images/Erklaerung_zum_Beschaeftigungsverhaeltnis-000002.png"' +
                '},{' +
                    '"path": "s3_Erklaerung_zum_Beschaeftigungsverhaeltnis-000003.png",' +
                    '"url": "http://resources-server/images/Erklaerung_zum_Beschaeftigungsverhaeltnis-000003.png"' +
                '},{' +
                    '"path": "s4_Erklaerung_zum_Beschaeftigungsverhaeltnis-000004.png",' +
                    '"url": "http://resources-server/images/Erklaerung_zum_Beschaeftigungsverhaeltnis-000004.png"' +
                '},{' +
                    '"path": "s5_Erklaerung_zum_Beschaeftigungsverhaeltnis-000005.png",' +
                    '"url": "http://resources-server/images/Erklaerung_zum_Beschaeftigungsverhaeltnis-000005.png"' +
                '},{' +
                    '"path": "lmsans8-regular.otf",' +
                    '"url": "http://resources-server/fonts/lmsans8-regular.otf"' +
                '},{' +
                    '"path": "Unterschrift+Stempel.png",' +
                    '"url": "http://resources-server/images/Unterschrift+Stempel.png"' +
                '},{' +
                    '"path": "main.tex",' +
                    '"url": "http://resources-server/templates/arbeitserlaubnis_formular.tex"' +
                '},{' +
                    '"path": "variablen.tex",' +
                    '"content": "\\\\setboolean{IsAufenthaltstitel}{false} ' + 
                                 '\\\\setboolean{IsVorabzustimmung}{true} ' + 
                                 '\\\\setboolean{IsErsterteilung}{false} ' + 
            					 '\\\\setboolean{IsVerlaengerung}{true} ' + 
            					 '\\\\newcommand{\\\\Name}{' + account.LastName +'} ' + 
            					 '\\\\newcommand{\\\\Vorname}{' + account.FirstName + ' ' + account.MiddleName + '} ' + 
             					 '\\\\setboolean{IsWeiblich}{' + account.Salutation.equals('Ms.') + '} ' + 
            					 '\\\\setboolean{IsMaennlich}{' + account.Salutation.equals('Mr.') + '} ' + 
            					 '\\\\setboolean{IsDivers}{' + account.Salutation.equals('Mx.') + '} ' + 
            					 '\\\\newcommand{\\\\Geburtsdatum}{' + account.PersonBirthdate.format() + '} ' + 
            					 '\\\\newcommand{\\\\Staatsangehörigkeit}{' + account.CountryOfOriginPick__c + '} ' + 
            					 '\\\\newcommand{\\\\Aufenthaltsort}{' + account.PersonMailingStreet + ', ' + account.PersonMailingPostalCode + ' ' + account.PersonMailingCity +'} ' + 
            					 '\\\\newcommand{\\\\Firma}{Social-Bee GmbH} ' + 
            					 '\\\\newcommand{\\\\Kontaktperson}{Simone Di Terlizzi} ' + 
            					 '\\\\newcommand{\\\\TelefonNummer}{089/18914481} ' + 
            					 '\\\\newcommand{\\\\Straße}{St.-Martin-Straße 112} ' + 
            					 '\\\\newcommand{\\\\PLZOrt}{81669 München} ' + 
            					 '\\\\newcommand{\\\\Fax}{089/24887906} ' + 
            					 '\\\\newcommand{\\\\EMail}{simone.diterlizzi@social-bee.de} ' + 
            					 '\\\\newcommand{\\\\Betriebsnummer}{95695562} ' + 
            					 '\\\\setboolean{IsNeueinreise}{true} ' + 
            					 '\\\\newcommand{\\\\beginnt}{} ' + 
            					 '\\\\setboolean{IsVerlaengerung}{false} ' + 
            					 '\\\\newcommand{\\\\besteht}{} ' + 
            					 '\\\\setboolean{IsBefristet}{true} ' + 
            					 '\\\\newcommand{\\\\befristet}{}' + 
            					 '\\\\setboolean{IsLeiharbeiter}{true} ' + 
            					 '\\\\setboolean{IsArbeitsort}{true} ' + 
            					 '\\\\newcommand{\\\\Ort}{Großraum München} ' + 
            					 '\\\\newcommand{\\\\BeschreibungTaetigkeit}{Helfertätigkeiten in Stellen der Produktionsbranche, in Lager und Logistik, im Verkauf, bei Verwaltungsaufgaben und Bürotätigkeiten, in der Gastronomie, im Hotelgewerbe, im Baunebengewerbe, im Pflegebereich.} ' + 
            					 '\\\\setboolean{IsKeinAbschluss}{true} ' + 
            					 '\\\\setboolean{IsHochschule}{false} ' + 
            					 '\\\\newcommand{\\\\AbschlussArt}{} ' + 
            					 '\\\\newcommand{\\\\AbschlussOrt}{} ' + 
            					 '\\\\setboolean{IsAbschlussVergleichbar}{false} ' + 
            					 '\\\\newcommand{\\\\NachweisAbschluss}{} ' + 
            					 '\\\\setboolean{IsBerufsausbildung}{false} ' + 
            					 '\\\\newcommand{\\\\Berufsausbildung}{} ' + 
            					 '\\\\newcommand{\\\\BerufsausbildungOrt}{} ' + 
            					 '\\\\setboolean{IsBeruflicheAnerkennungJa}{false} ' + 
            					 '\\\\setboolean{IsBeruflicheAnerkennungNein}{false} ' + 
            					 '\\\\setboolean{IsBeruflicheAnerkennungTeilweise}{false} ' + 
            					 '\\\\newcommand{\\\\Nachweis}{} ' + 
            					 '\\\\setboolean{IsSonstigeAusbildung}{true} ' + 
            					 '\\\\newcommand{\\\\Faehigkeiten}{Deutschkenntnisse A2} ' + 
            					 '\\\\setboolean{IsKeineAusbildungFreiwillig}{true} ' + 
            					 '\\\\newcommand{\\\\FreiwilligeAngabe}{} ' + 
            					 '\\\\setboolean{IsBerufsausuebungserlaubnis}{false} ' + 
            					 '\\\\newcommand{\\\\QualifikationErlaubnis}{} ' + 
            					 '\\\\setboolean{IsVollzeit}{true} ' + 
            					 '\\\\newcommand{\\\\Vollzeit}{35} ' + 
            					 '\\\\setboolean{IsTeilzeit}{false} ' + 
            					 '\\\\newcommand{\\\\Teilzeit}{} ' + 
            					 '\\\\setboolean{IsGeringfuegigeBeschaeftigung}{false} ' + 
            					 '\\\\newcommand{\\\\GeringfuegigeBeschaeftigung}{} ' + 
            					 '\\\\setboolean{IsUeberstundenpflicht}{false} ' + 
            					 '\\\\newcommand{\\\\Ueberstundenzahl}{} ' + 
            					 '\\\\newcommand{\\\\Ueberstundenausgleich}{} ' + 
            					 '\\\\newcommand{\\\\ArbeitstageProUrlaubsjahr}{24} ' + 
            					 '\\\\setboolean{IsTarifvertrag}{true} ' + 
            					 '\\\\newcommand{\\\\Tarifvertrag}{IGZ} ' + 
            					 '\\\\newcommand{\\\\Entgeltgruppe}{1} ' + 
            					 '\\\\setboolean{IsVereinbarungArbeitsvertrag}{false} ' + 
            					 '\\\\setboolean{IsLohn}{true} ' + 
            					 '\\\\setboolean{IsGehalt}{false} ' + 
            					 '\\\\setboolean{IsProStunde}{true} ' + 
            					 '\\\\newcommand{\\\\Stunde}{Mind. 10,88 Euro} ' + 
            					 '\\\\setboolean{IsProMonat}{false} ' + 
            					 '\\\\newcommand{\\\\ProMonat}{} ' + 
            					 '\\\\setboolean{IsGeldwerteLeistung}{false} ' + 
            					 '\\\\newcommand{\\\\GeldwerteLeistungForm}{} ' + 
            					 '\\\\newcommand{\\\\GeldwerteLeistung}{} ' + 
            					 '\\\\setboolean{IsSonstigeBerechnung}{false} ' + 
            					 '\\\\newcommand{\\\\SonstigeBerechnung}{} ' + 
            					 '\\\\setboolean{IsSozialversicherungspflicht}{true} ' + 
            					 '\\\\newcommand{\\\\KeineSozialversicherungspflicht}{} ' + 
            					 '\\\\setboolean{IsRueckstaendeSozSteu}{false} ' + 
            					 '\\\\setboolean{IsStrafBussgeld}{false} ' + 
            					 '\\\\setboolean{IsInsolvenz}{false} ' + 
            					 '\\\\setboolean{IsInsolvenzAbgelehnt}{false} ' + 
            					 '\\\\newcommand{\\\\Gruendungsjahr}{2016} ' + 
            					 '\\\\newcommand{\\\\AnzahlAN}{124} ' + 
            					 '\\\\setboolean{IsVerwandtschaft}{false} ' + 
            					 '\\\\newcommand{\\\\Amtsgericht}{} ' + 
            					 '\\\\newcommand{\\\\Registernummer}{} ' + 
            					 '\\\\newcommand{\\\\WeitereAngabenSvier}{} ' + 
            					 '\\\\newcommand{\\\\OrtDatum}{München, \\\\today}"' +
                '}]' +
            '}' +
        '}';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpointCompile);
        req.setMethod('POST');
        req.setBody(body);
        req.setHeader('Content-TYpe', 'application/json');
        req.setTimeout(40000);

        HTTPResponse res = new Http().send(req);
        System.debug(res.getStatus());
        System.debug(res.getBody());

        JSONParser parser = JSON.createParser(res.getBody());

        CompileObjectResult result = (CompileObjectResult)parser.readValueAs(CompileObjectResult.class);
        System.debug(result.compile);
        System.debug(result.compile.status);

        // no error handling
        if(res.getStatusCode() == 200){
            String buildId = result.compile.outputFiles[0].build;

            // Instantiate a new http object
            Http h = new Http();
            // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
            HttpRequest requestDownload = new HttpRequest();
            requestDownload.setEndpoint(endpointBase + '/build/'+ buildId +'/output/output.pdf');
            requestDownload.setTimeout(60000);//sets maximum timeout
            requestDownload.setMethod('GET');
            // Send the request, and return a response
            HttpResponse responseDownload = h.send(requestDownload);
            Blob pdfBlob = responseDownload.getBodyAsBlob();

            //then you can attach this body wherever you want
            addAttachmentToAccount(accountId, pdfBlob, 'Erklärung zum Beschäftigungsverhältnis' + '_' + account.LastName + '.pdf');

        }
        return 'PDF sucessfully generated';
    }

    public static ContentVersion createContentVersion(String name, Blob body){
        ContentVersion contentVersion = new ContentVersion();
        contentVersion.ContentLocation = 'S'; // S = Stored in Salesforce
        contentVersion.PathOnClient = name;
        contentVersion.Title = name;
        contentVersion.VersionData = body;
        return contentVersion;
    }

    private static ContentDocumentLink createContentDocumentLink(Id contentDocumentId, Id parentId){
        ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
        contentDocumentLink.ContentDocumentId = contentDocumentId;
        contentDocumentLink.LinkedEntityId = parentId;
        contentDocumentLink.ShareType = 'I'; // Inferred permission
        //contentDocumentLink.Visibility = 'InternalUsers';
        return contentDocumentLink;
    }

    private static void addAttachmentToAccount(Id accountId, Blob body, String filename) {
        ContentVersion contentVersion = createContentVersion(filename, body);
        
        insert contentVersion;
    
        contentVersion = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id];
        
        ContentDocumentLink contentDocumentLink = createContentDocumentLink(contentVersion.ContentDocumentId, accountId);
        
        insert contentDocumentLink;
    }

    public class MyException extends Exception{}

    public class CompileObjectResult{
        public CompileEntry compile;
    }

    public class CompileEntry{
        public String status;
        public String error;
        public List<OutputFile> outputFiles;
    }

    public class OutputFile{
        public String url;
        public String path;
        public String type;
        public String build;
    }
}