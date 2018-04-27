/* Application Configuration
 * 
 * @Contributors
 * Parth Shah
 *
 * @Version
 * 1.0
 *
 */

(function() {

    window.config = window.config || {};

    (function(config) {

        /********************************** Master Config Start ************************************/

        config.currentDateTime = new Date().getTime();
        config.currentDate = new Date();

        /********************************** Master Config End ************************************/

        /********************************** iBuild Config Start ***************************************/



        config.domain = "http://localhost:8000"; //MUST BE CHANGE WITH SERVER IP
        config.apiUrl = "/api/webApi.php";
        config.defaultParam = {
            'apiName': "", //name of api to call eg. getUserDetails,  it matchis with webApi.php's switch case
            'data': {}, //used for post request
            'talentMap': "webCall" //just a key to check that this request came from web application, further can be used as authentication
        };
        //status code same as PHP config's status code., if any new added, add it in config.php file.
        config.statusCode = {
            "taskCompleted": 200,
            "taskIncompleted": 204,
            "invalidApiName": 404,
            "validApiName": 200,
            "unAuthorisedApiCall": 400,
            "databaseDown": 204
        };


        config.fileUploadAPI = ""; // TODO - API call of file upload php  Change ip with actual ip
        config.fileDownloadAPI = ""; // TODO - API call of file download Change ip with actual ip

        config.defaultProfilePic = "data:image/png;base64,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";
        config.defaultProfilePicDocType = "png";

        /************************************** Regular Expresion List Start **************************************/

        window.config.emailRegEx = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        window.config.floatRegEx = /^-?\d*(\.\d+)?$/;
        window.config.alphaNumericRegEx = /^[a-z0-9]+$/i;
        window.config.alphaNumericWithSpaceRegEx = /^[a-z 0-9]+$/i;
        window.config.alphaNumericSomeSpCharRegEx = /^[a-z0-9 .,?-]+$/i;
        window.config.validPasswordRegEx = /^[0-9]{4}$/i;
        /************************************** Regular Expresion List End **************************************/
    })(window.config);

})();