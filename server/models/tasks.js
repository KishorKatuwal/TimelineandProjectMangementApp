const mongoose = require("mongoose");

const tasksSchema = mongoose.Schema({
  id: {
    type: String,
    required: true,
    trim: true,
  },
  status :{
    type: Boolean,
    required: true,
  },
  taskName :{
      type: String,
      required: true,
    },

});

const Tasks = mongoose.model("Tasks",tasksSchema);
module.exports = Tasks;
