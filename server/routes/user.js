const express = require('express');
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const  Events  = require('../models/event');
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



module.exports = userRouter;