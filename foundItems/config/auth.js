// expose our config directly to our application using module.exports
module.exports = {

    'facebookAuth' : {
        'clientID'      : '962745520469186', // your App ID
        'clientSecret'  : '60d7ab21273bb4b8037f687d52a64662', // your App Secret
        'callbackURL'   : 'http://localhost:8080/auth/facebook/callback'
    },

    'twitterAuth' : {
        'consumerKey'       : 'gqlI2041gLgko2WsOMa9SbKiO',
        'consumerSecret'    : 'smP76pMtuj4OTeSwtMedmXjyvUqp0xRCl2XyxLCAU4pc3PcA6M',
        'callbackURL'       : 'http://localhost:8080/auth/twitter/callback'
    },

    'googleAuth' : {
        'clientID'      : '1057714439150-2192bao776fhdd850of6jli1hl6u2f2e.apps.googleusercontent.com',
        'clientSecret'  : '62_Y4tEykDuxx0KSVdy6fC5L',
        'callbackURL'   : 'http://localhost:8080/auth/google/callback'
    }

};