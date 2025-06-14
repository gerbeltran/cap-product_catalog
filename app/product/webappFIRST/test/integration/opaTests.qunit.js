sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'logaligroup/product/test/integration/FirstJourney',
		'logaligroup/product/test/integration/pages/ProductsSrvList',
		'logaligroup/product/test/integration/pages/ProductsSrvObjectPage',
		'logaligroup/product/test/integration/pages/ReviewSrvObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsSrvList, ProductsSrvObjectPage, ReviewSrvObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('logaligroup/product') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsSrvList: ProductsSrvList,
					onTheProductsSrvObjectPage: ProductsSrvObjectPage,
					onTheReviewSrvObjectPage: ReviewSrvObjectPage
                }
            },
            opaJourney.run
        );
    }
);