sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'logaligroup/projectproduct/test/integration/FirstJourney',
		'logaligroup/projectproduct/test/integration/pages/ProductsSrvList',
		'logaligroup/projectproduct/test/integration/pages/ProductsSrvObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsSrvList, ProductsSrvObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('logaligroup/projectproduct') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsSrvList: ProductsSrvList,
					onTheProductsSrvObjectPage: ProductsSrvObjectPage
                }
            },
            opaJourney.run
        );
    }
);