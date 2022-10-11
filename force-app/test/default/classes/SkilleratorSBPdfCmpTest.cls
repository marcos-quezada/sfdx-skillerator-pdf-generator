@isTest
private class SkilleratorPdfComponentTest {
    @isTest static void doCalloutTest() {
        SingleRequestHttpCalloutMock mock = new SingleRequestHttpCalloutMock(200, 'OK', '', new Map<String, String>{ 'Content-Type' => 'application/json' });
        Account tPersonAccount = TestObjectFactory.tPersonAccount;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
            SkilleratorPdfComponent.doCallout(tPersonAccount.Id);
        Test.stopTest();
    }

    @isTest static void createContentVersionTest(){
        Blob testBlob=Blob.valueOf('Unit Test Attachment Body');
        Test.startTest();
            SkilleratorPdfComponent.createContentVersion('Test', testBlob);
        Test.stopTest();
    }
    
}