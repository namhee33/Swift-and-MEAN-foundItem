var mongoose = require('mongoose');
var itemSchema = new mongoose.Schema({
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

module.exports = mongoose.model('Item', itemSchema);