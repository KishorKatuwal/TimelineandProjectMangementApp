const mongoose = require("mongoose");

const eventSchema = mongoose.Schema({
  EventName: {
    type: String,
    required: true,
    trim: true,
  },
  EventDate :{
    type: String,
    required: true,
  },
  EventTime :{
      type: String,
      required: true,
    },
   Repeat :{
          type: String,
          required: true,
        },
  Description: {
    type: String,
    required: true,
    trim: true,
  },
  EventType: {
    type: String,
    required: true,
  },

});

const Events = mongoose.model("Events", eventSchema);
module.exports = Events;
