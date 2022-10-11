@isTest
private class SkilleratorSBPdfCmpTest {
    @isTest static void doCalloutTest() {
        SingleRequestHttpCalloutMock mock = new SingleRequestHttpCalloutMock(200, 'OK', '', new Map<String, String>{ 'Content-Type' => 'application/json' });
        Account tPersonAccount = TestObjectFactory.tPersonAccount;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
            SkilleratorSBPdfCmp.doCallout(tPersonAccount.Id);
        Test.stopTest();
    }

    @isTest static void createContentVersionTest(){
        Blob testBlob=Blob.valueOf('Unit Test Attachment Body');
        Test.startTest();
            SkilleratorSBPdfCmp.createContentVersion('Test', testBlob);
        Test.stopTest();
    }
    
}