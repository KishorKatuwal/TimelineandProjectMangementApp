const mongoose = require("mongoose");


const feedbackSchema = mongoose.Schema({
  userId: {
    required: true,
    type: String,
    trim: true,
  },
  userEmail: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
  feedbackType: {
    required: true,
    type: String,
    trim: true,
  },
  description: {
    required: true,
    type: String,
    trim: true,
  },


});


const Feedback = mongoose.model("Feedback", feedbackSchema);
module.exports = Feedback;