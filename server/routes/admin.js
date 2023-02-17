const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const Feedback  = require('../models/feedback');
const User  = require('../models/user');


//fetching feedback
adminRouter.get('/admin/get-feedback', admin, async (req, res) => {
    try {
        const feedbacks = await Feedback.find({});
        res.json(feedbacks);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//deleting feedback
adminRouter.post('/admin/delete-feedback', admin, async (req, res) => {
    try {
        const { id } = req.body;
        let feedback = await Feedback.findByIdAndDelete(id);
        res.json(feedback);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//getting users
adminRouter.get('/admin/get-users', admin, async (req, res) => {
    try {
        const users = await User.find({});
        res.json(users);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//deleting users
adminRouter.post('/admin/delete-user', admin, async (req, res) => {
    try {
        const { id } = req.body;
        let user = await User.findByIdAndDelete(id);
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});




module.exports = adminRouter;