const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
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
      return value.lenght > 6;
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
  type: {
    type: String,
    default: "user",
  },
  //details
});

const User = mongoose.model("User", userSchema);
module.exports = User;
