var mongoose = require('mongoose');
var ItemSchema = new mongoose.Schema({
	userName: String,
	location: String,
	itemName: String,
	detail: String,
	locationY: Number,
	locationX: Number,
	imageUrl: String,
	createdAt: Date,
	founds: {type: Array}
});

mongoose.model('Item', ItemSchema);
