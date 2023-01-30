const mongoose = require("mongoose");
const Tasks = require('./tasks');

const projectsSchema = mongoose.Schema({
  projectName: {
    type: String,
    required: true,
    trim: true,
  },
 tasks: [Tasks.schema],
});

const Projects = mongoose.model("Projects", projectsSchema);
module.exports = Projects;
