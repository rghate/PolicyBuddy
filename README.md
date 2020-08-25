Deployment target: iOS11.0
Mode: Portrait 
Swift version: Swift 5


Screen Recording: PolicyBuddy/Docs/Screen Recording.mov


Third party libraries:
1. Material - For UI effects on home screen 'Motor' and 'Travel' buttons. I added it with the intension of using it for other UI components, but currently its being used only on home screen. 


Features:
- Completed all the features mentioned in the requirement document, including part of optional 'standard-text' feature.
- Pull down to refresh to load fresh data from the server. 
- Paging feature on home screen to swipe between Motor and Travel policy page
- Responsive countdown curcular progressbar to display remaining duration of the active policies. The progressbar caculates and displays duration from number of days down till seconds. 
- Code is extendible with minimum changes to accomodate paging behavior on 'Policy details' screen using ViewControllers/Policy Details/PolicyPagingController.swift file.
- Unit testing to test viewmodel and network layer. 
- Network error handling and alert messages displayed where required.  


Please Note:

1. Downloaded policy data is stored in locally in 'PolicyData.json' file.

2. Created a test json file (./Resources/TestFile.json) for testing active policies (by modifying end-dates of policies). To read data from test file, set ‘readTestData’ property to true in APIService.swift.

3. Added exception for www.mocky.io and its sub domains to allow arbitrary load. Info.plist will have to be modified to allow insecure load from any other site.

4. Home screen and policy details screen uses strings from the 'standard-text' feature. I was not completely clear on rest of the string froom the server response, so the Receipt screen does not use downloaded standard-text values. 

4. Since the gaps between UI controls are not specified, I took reference from based on iPhone-11 max pro simulator. It may look bit different on older resolution devices.

    
    Improvements:
    
    1.  Storing offline policy data in Keychain for more secure storage.
    2.  Better decoding of downloaded pollicy data into models.
    3. UI Testing.
    4. Making application localization ready.
    5. More performance tuning for smoother UI.
    6. More modular home screen to include new policy-type (Motor, vehicle, heallth etc) with minimum changes. 
    

    
    
