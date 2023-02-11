const express = require('express');
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const  Events  = require('../models/event');
const  Projects  = require('../models/projects');
const  Feedback  = require('../models/feedback');
const  Discussion  = require('../models/discussion');
const User = require('../models/user');

//adding events
userRouter.post("/api/add-event", auth, async (req, res) => {
    try {
           const { EventName, EventDate, EventTime, Repeat, Description, EventType }= req.body;
           let user = await User.findById(req.user);
           user.events.push({EventName, EventDate, EventTime, Repeat, Description, EventType });
           //saving to database
           user = await user.save();
           //product = await product.save();
           console.log("reached here");
           res.json(user);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});


//fetching events
userRouter.get('/api/get-events',auth, async (req, res) => {
    try {
        let user = await User.findById(req.user);
        const userEvents = user.events;
//        console.log(userEvents);
        res.json(userEvents);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});

//deleting events
userRouter.delete("/api/delete-events",auth, async (req, res) => {
    try {
        const { EventID } = req.body;
        let user = await User.findById(req.user);
        const existingEvents = await user.events;
       for(let i=0; i<existingEvents.length; i++){
        if(existingEvents[i]._id==EventID){
            user.events.splice(i, 1);
        }
        }
       user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({error: e.message});
    }

});

//adding project
    userRouter.post("/api/add-project", auth, async (req, res) => {
        try {
               const { projectName,projectDescription,startDate,endDate,isCompleted,
                tasks }= req.body;
//               console.log(req.body);
               let user = await User.findById(req.user);
               user.projects.push({projectName, projectDescription,startDate,endDate,isCompleted ,tasks});
               //saving to database
               user = await user.save();
               res.json(user);
        } catch (e) {
            res.status(500).json({error: e.message});
        }
    });


//getting all the projects
    userRouter.get('/api/get-projects',auth, async (req, res) => {
        try {
            let user = await User.findById(req.user);
            const userProjects = user.projects;
            res.json(userProjects);
        } catch (e) {
            res.status(500).json({ error: e.message });
        }

    });


    //deleting events
    userRouter.delete("/api/delete-project",auth, async (req, res) => {
        try {
            const { projectId } = req.body;
            let user = await User.findById(req.user);
            const existingProjects = await user.projects;
           for(let i=0; i<existingProjects.length; i++){
            if(existingProjects[i]._id==projectId){
                user.projects.splice(i, 1);
            }
            }
           user = await user.save();
            res.json(user);
        } catch (e) {
            res.status(500).json({error: e.message});
        }

    });





//updating task
userRouter.put("/api/update-tasks",auth, async (req, res) => {
try {
    const { projectId,taskId,taskStatus } = req.body;
//    console.log(req.body);
    let user = await User.findById(req.user);
    let existingProject = user.projects.id(projectId);
    if (!existingProject) return res.status(404).json({ error: 'Project not found' });
    let existingTask = existingProject.tasks.id(taskId);
    if (!existingTask) return res.status(404).json({ error: 'Task not found' });
    existingTask.status = taskStatus;
    user.save();
    res.json(user);
} catch (e) {
res.status(500).json({error: e.message});
}
});




//updating project status
userRouter.put("/api/update-project-status",auth, async (req, res) => {
try {
    const { projectId,projectStatus } = req.body;
    let user = await User.findById(req.user);
    let existingProject = user.projects.id(projectId);
    if (!existingProject) return res.status(404).json({ error: 'Project not found' });
    existingProject.isCompleted= projectStatus;
    user.save();
    res.json(user);
} catch (e) {
res.status(500).json({error: e.message});
}
});





//giving feedback
userRouter.post('/api/give-feedback',auth, async(req,res)=>{
try{
    const {userId, userEmail, feedbackType, description} = req.body;
    let feedback = new Feedback({userId, userEmail, feedbackType, description});
    feedback = await feedback.save();
    res.json(feedback);
}catch(e){
    res.status(500).json({error: e.message});

}

});



//adding message
userRouter.post('/api/send-message',auth, async(req,res)=>{
try{
    const {message, messageTime, userId, userName, userGroup, userYear} = req.body;
    let discussion = new Discussion({message, messageTime, userId, userName, userGroup, userYear});
    discussion = await discussion.save();
    res.json(discussion);
}catch(e){
    res.status(500).json({error: e.message});

}

});



//getting messages
    userRouter.get('/api/get-messages',auth, async (req, res) => {
        try {
            const discussion = await Discussion.find({});
            res.json(discussion);
        } catch (e) {
            res.status(500).json({ error: e.message });
        }

    });



//editing user information
userRouter.put("/api/update-user-details",auth, async (req, res) => {
try {
    const { firstName,lastName,group,faculty,year } = req.body;
    let user = await User.findById(req.user);
    user.firstName = firstName;
    user.lastName = lastName;
    user.group = group;
    user.faculty = faculty;
    user.year = year;
    user.save();
    res.json(user);
} catch (e) {
res.status(500).json({error: e.message});
}
});




module.exports = userRouter;