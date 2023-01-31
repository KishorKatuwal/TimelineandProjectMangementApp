const express = require('express');
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const  Events  = require('../models/event');
const  Projects  = require('../models/projects');
const User = require('../models/user');


userRouter.post("/api/add-event", auth, async (req, res) => {
    try {
           const { EventName, EventDate, EventTime, Subject, Description, EventType }= req.body;
           let user = await User.findById(req.user);
           user.events.push({EventName, EventDate, EventTime, Subject, Description, EventType });
           //saving to database
           user = await user.save();
           //product = await product.save();
           console.log("reached here");
           res.json(user);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});

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



    userRouter.get('/api/get-projects',auth, async (req, res) => {
        try {
            let user = await User.findById(req.user);
            const userProjects = user.projects;
            console.log(userProjects);
            res.json(userProjects);
        } catch (e) {
            res.status(500).json({ error: e.message });
        }

    });




module.exports = userRouter;