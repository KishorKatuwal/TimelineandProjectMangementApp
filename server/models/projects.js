const mongoose = require("mongoose");
const Tasks = require('./tasks');

const projectsSchema = mongoose.Schema({
  projectName: {
    type: String,
    required: true,
    trim: true,
  },
    projectDescription: {
      type: String,
      required: true,
      trim: true,
    },
      startDate: {
        type: String,
        required: true,
        trim: true,
      },
        endDate: {
          type: String,
          required: true,
          trim: true,
        },
          isCompleted: {
            type: Boolean,
            required: true,
          },
 tasks: [Tasks.schema],
});

const Projects = mongoose.model("Projects", projectsSchema);
module.exports = Projects;
