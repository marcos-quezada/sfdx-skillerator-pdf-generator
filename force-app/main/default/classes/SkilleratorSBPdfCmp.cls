public class SkilleratorSBPdfCmp {
    @AuraEnabled
    public static String doCallout(Id accountId){
        if(accountId == null){
            throw new MyException('Missing record id');
        }

        String endpointBase = 'http://159.223.24.62/project/sb-';
        endpointBase += accountId;
        String endpointCompile = endpointBase + '/compile';
        
        List<Account> accounts = [SELECT toLabel(CountryOfOriginPick__c),Description,FirstName,Gender__pc,LastName,MiddleName,PersonBirthdate,Salutation,PersonMailingStreet,PersonMailingPostalCode,PersonMailingCity FROM Account WHERE Id = :accountId];
        if(accounts.isEmpty()){
            throw new MyException('Could not find the account');
        }
        
        Account account = accounts[0];
        
        String genderStr = account.Salutation;
        
        List<String> nameTokens = new List<String>();
        nameTokens.add(account.FirstName);
        if(account.MiddleName != null){
            nameTokens.add(account.MiddleName);
        }

        ConditionalDateDataEntry befristet = new ConditionalDateDataEntry('true', System.Now().addDays(-1).addYears(2));
        ConditionalDateDataEntry neueinreise = new ConditionalDateDataEntry('true', System.Now());

        String body = '{' +
            '"compile": {' +
                '"options": {' +
                    '"compiler": "xelatex",' +
                    '"timeout": 40' + 
                '},' +
                '"resources": [{' +
                    '"path": "Stellenbeschreibung1.png",' +
                    '"url": "http://resources-server/images/Stellenbeschreibung1.png"' +
                '},{' +
                    '"path": "Stellenbeschreibung1.png",' +
                    '"url": "http://resources-server/images/Stellenbeschreibung1.png"' +
                '},{' +
                    '"path": "lmsans8-regular.otf",' +
                    '"url": "http://resources-server/fonts/lmsans8-regular.otf"' +
                '},{' +
                    '"path": "Unterschrift+Stempel.png",' +
                    '"url": "http://resources-server/images/Unterschrift+Stempel.png"' +
                '},{' +
                    '"path": "main.tex",' +
                    '"url": "http://resources-server/templates/stellenbeschreibung_formular.tex"' +
                '},{' +
                    '"path": "variablen.tex",' +
                    '"content": "\\\\newif\\\\ifIsWeiblich\\\\IsWeiblich' + account.Salutation.equals('Ms.') + ' ' + 
                                 '\\\\newif\\\\ifIsMaennlich\\\\IsMaennlich' + account.Salutation.equals('Mr.') + ' ' + 
                                 '\\\\newif\\\\ifIsDivers\\\\IsDivers' + account.Salutation.equals('Mx.') + ' ' + 
                                 '\\\\newcommand{\\\\Name}{' + account.LastName +'} ' + 
            					 '\\\\newcommand{\\\\Vorname}{' + String.join(nameTokens, ' ') + '} ' + 
                                 '\\\\newcommand{\\\\Geburtsdatum}{' + account.PersonBirthdate.format() + '} ' + 
            					 '\\\\newcommand{\\\\Staatsangehörigkeit}{' + account.CountryOfOriginPick__c + '} ' + 
                                 '\\\\newcommand{\\\\KontaktSocialBee}{Social-Bee gGmbH\\\\\\\\St.-Martin-Straße 112\\\\\\\\81669 München\\\\\\\\info@social-bee.de} ' +
                                 '\\\\newcommand{\\\\Betriebsnummer}{95695562} ' + 
                                 '\\\\newif\\\\ifIsVerlaengerung\\\\IsVerlaengerungtrue ' + 
                                 '\\\\newif\\\\ifIsNeueinreise\\\\IsNeueinreise' + neueinreise.isFieldChecked + ' ' + 
                                 '\\\\newcommand{\\\\Berufsbezeichnung}{Helfer} ' +
                                 '\\\\newcommand{\\\\BeschreibungTaetigkeit}{Helfertätigkeiten in Stellen der Produktionsbranche, in Lager und Logistik, im Verkauf, bei Verwaltungsaufgaben und Bürotätigkeiten, in der Gastronomie, im Hotelgewerbe, im Baunebengewerbe, im Pflegebereich.} ' +
                                 '\\\\newif\\\\ifIsLeiharbeiter\\\\IsLeiharbeitertrue ' + 
                                 '\\\\newcommand{\\\\Faehigkeiten}{Deutschkenntnisse A2} ' +
                                 '\\\\newif\\\\ifIsFuehrerschein\\\\IsFuehrerscheinfalse ' +
                                 '\\\\newcommand{\\\\Fuehrerscheinklasse}{} ' + 
                                 '\\\\newif\\\\ifIsKeinAbschluss\\\\IsKeinAbschlusstrue ' + 
                                 '\\\\newif\\\\ifIsVollzeit\\\\IsVollzeittrue ' + 
            					 '\\\\newcommand{\\\\Vollzeit}{35} ' + 
                                 '\\\\newif\\\\ifIsArbeitsort\\\\IsArbeitsorttrue ' + 
            					 '\\\\newcommand{\\\\Ort}{Großraum München} ' + 
                                 '\\\newif\\\\ifIsAbSofort\\\\IsAbSoforttrue ' +
                                 '\\\\newcommand{\\\\beginnt}{' + neueinreise.fieldValue + '} ' + 
                                 '\\\\newif\\\\ifIsBefristet\\\\IsBefristet' + befristet.isFieldChecked + ' ' + 
            					 '\\\\newcommand{\\\\befristet}{' + befristet.fieldValue + '}' + 
                                 '\\\\newif\\\\ifIsLohn\\\\IsLohntrue ' + 
            					 '\\\\newif\\\\ifIsGehalt\\\\IsGehaltfalse ' + 
                                 '\\\\newif\\\\ifIsProStunde\\\\IsProStundetrue ' + 
            					 '\\\\newcommand{\\\\Stunde}{Mind. IGZ Mindestlohn} ' + 
            					 '\\\\newif\\\\ifIsProMonat\\\\IsProMonatfalse ' + 
            					 '\\\\newcommand{\\\\ProMonat}{} ' + 
                                 '\\\\newif\\\\ifIsGeldwerteLeistung\\\\IsGeldwerteLeistungfalse ' + 
            					 '\\\\newcommand{\\\\GeldwerteLeistungForm}{} ' + 
            					 '\\\\newcommand{\\\\GeldwerteLeistung}{} ' + 
                                 '\\\\newif\\\\ifIsTarifvertrag\\\\IsTarifvertragtrue ' + 
            					 '\\\\newcommand{\\\\Tarifvertrag}{IGZ} ' + 
            					 '\\\\newcommand{\\\\Entgeltgruppe}{1} ' + 
                                 '\\\\newif\\\\ifIsVereinbarungArbeitsvertrag\\\\IsVereinbarungArbeitsvertragfalse ' + 
                                 '\\\\newif\\\\ifIsUeberstundenpflicht\\\\IsUeberstundenpflichtfalse ' + 
                                 '\\\\newcommand{\\\\ArbeitstageProUrlaubsjahr}{24} ' + 
                                 '\\\\newif\\\\ifIsBevorzugung\\\\IsBevorzugungtrue ' +
                                 '\\\\newcommand{\\\\FreiwilligeAngabe}{} ' + 
                                 '\\\\newcommand{\\\\OrtDatum}{München, \\\\today}"' +
                                 '\\\\newcommand{\\\\Kontaktperson}{Simone Di Terlizzi} ' + 
            					 '\\\\newcommand{\\\\TelefonNummer}{089/18914481} ' + 
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
            addAttachmentToAccount(accountId, pdfBlob, 'Stellenbeschreibung' + '_' + account.LastName + '.pdf');

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

    public class ConditionalDateDataEntry{
        public Boolean isFieldChecked;
        public String fieldValue;

        public ConditionalDateDataEntry(String isChecked, Datetime fieldDate){
            isFieldChecked = Boolean.valueOf(isChecked);
            fieldValue = '';
            if(isFieldChecked){
                fieldValue = fieldDate.format('dd.MM.yyyy');
            }
        }
    }
}