const mongoose = require("mongoose");
const Events = require('./event');
const Projects = require('./projects');

const userSchema = mongoose.Schema({
  firstName: {
    required: true,
    type: String,
    trim: true,
  },
  lastName: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
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
  password: {
    required: true,
    type: String,
    validator: (value) => {
      return value.length > 6;
    },
    message: "Please insert a long Password",
  },
  group: {
    required: true,
    type: String,
    trim: true,
  },
  faculty: {
    required: true,
    type: String,
    trim: true,
  },
    year: {
      required: true,
      type: String,
      trim: true,
    },
  type: {
    type: String,
    default: "user",
  },
  //for events
  events: [Events.schema],
  //for projects
  projects: [Projects.schema],
});


const User = mongoose.model("User", userSchema);
module.exports = User;
