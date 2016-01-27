var mongoose = require('mongoose');
var fs = require('fs');
// mongoose.connect('mongodb://192.168.0.29/weekproject');
// mongoose.connect('mongodb://localhost/weekproject');
mongoose.connect('mongodb://192.168.1.152/weekproject');
var models_path = __dirname + '/../server/models';
fs.readdirSync(models_path).forEach(function(file){
	if(file.indexOf('.js') > 0){
		require(models_path + '/' + file);
	}
})