const mongoose = require("mongoose");


const discussionSchema = mongoose.Schema({
  message: {
    required: true,
    type: String,
    trim: true,
  },
  messageTime: {
    required: true,
    type: String,
    trim: true,
  },
  userId: {
    required: true,
    type: String,
    trim: true,
  },
    userName: {
      required: true,
      type: String,
      trim: true,
    },
    userGroup: {
      required: true,
      type: String,
      trim: true,
    },
    userYear: {
      required: true,
      type: String,
      trim: true,
    },


});


const Discussion = mongoose.model("Discussion", discussionSchema);
module.exports = Discussion;